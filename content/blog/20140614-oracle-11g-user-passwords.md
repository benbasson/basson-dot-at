---
author: Ben Basson
title: Oracle 11g User Passwords
subtext: A quick, simple script to check that I did my job properly...
date: 2014-06-14T15:50:31
shortname: oracle-11g-user-passwords
summary: When setting up a new database, it's sometimes easy to forget that Oracle users are almost universally created with default/poor passwords. This blog provides some general background information on how Oracle stores passwords, and the script that I wrote to check if they've been changed to something more secure.
---

When setting up a new database, it's sometimes easy to forget that Oracle users are almost universally created with default/poor passwords. This problem is compounded when you have a lot of users to create, as verifying that the passwords are secure by logging into each user doesn't scale very well.

This blog provides some general background information on how Oracle stores passwords, and the script that I wrote to check if they've been changed to something more secure.

Setting Oracle user passwords
-----------------------------

When you create a user, you can specify how that user should authenticate. There are some [other options][1] available, but typically you'll be using a password:

~~~ sql
CREATE USER bob IDENTIFIED BY apassword
~~~

You can modify this later with an `ALTER USER` statement:

~~~ sql
ALTER USER bob IDENTIFIED BY anotherpassword
~~~

It's worth noting that the string you pass here isn't a delimited VARCHAR2, but it *is* still case aware. This seems to me to be a curiosity of the Oracle syntax, as typically undelimited tokens are treated as upper-case.

Case sensitivity
----------------

Prior to Oracle 11g the case of the password was ignored, that is to say, passwords were stored and verified in a case insensitive way. 

Starting with Oracle 11g, the default behaviour is for passwords to be stored both case sensitively and case insensitively; with 11g clients using the case sensitive variant if the database is configured to do so.

You can verify whether your Oracle 11g database is set to use case sensitive passwords like so:

~~~ sql
SELECT value
FROM v$parameter
WHERE name = 'sec_case_sensitive_logon'
~~~

You should see the value `TRUE`.

Oracle's password storage
-------------------------

Oracle stores passwords along with the users in the system table `SYS.USER$`. If you investigate this table, you'll note that there are two columns that look interesting... the obviously named `PASSWORD`, and the slightly more obfuscated `SPARE4`.

~~~ sql
SELECT password, spare4
FROM sys.user$
WHERE name = 'SCOTT'
~~~

~~~ text
PASSWORD          SPARE4                                                        
----------------- --------------------------------------------------------------
F894844C34402B67  S:0BE82D9F2D8E40AF72396F61DDDDCDC2980BEA3326F15339BB1DFDFE8EAA
~~~

The `SPARE4` column is used to store a salted, [SHA-1][2] hash of the password (case sensitively, if enabled). The astute amongst you will note that the stored value is longer than the 40 bytes you'd expect from a SHA-1 hash, this is because the 20 byte salt is concatenated to the end of it.

The `PASSWORD` column is there for backwards compatibility with 10g and earlier clients, and stores a case insensitive [3-DES][3] hash. You can read a great deal more about this in a blog post about [Oracle Password Hashes][4] by Marcel Lambrecht.

If you're wondering whether it's safe to delete values from the `PASSWORD` column; yes - assuming you haven't got any 10g or earlier clients that need to connect. 

These could come in the form of libraries used on the application tier, IDEs such as TOAD or SQL\*Developer, maintenance scripts running via SQL\*Plus and who knows what else, so it pays to be thorough. 

If you do commit yourself to the removal of these less secure password hashes, then you'll probably also want to stop them coming back by setting the `sqlnet.ora` parameter `SQLNET.ALLOWED_LOGON_VERSION` as described by Stefan Oehrli in his blog post [Case Sensitive Passwords and Strong User Authentication][5].

Why would you need to check that passwords have been changed?
-------------------------------------------------------------

Our production and user test environments are locked down and audited as you would expect, but I always think it's nice to be able to apply some extra due-diligence whenever I'm involved in release management or initial database configuration. 

A lot of older maintenance scripts use a [well documented temporary password change trick][6] using stored hashes to avoid the inclusion of plain text passwords as part of the script, and the cynic in me assumes that, given enough scripts and enough time, things will be written back incorrectly.

With that in mind, I wanted a quick way to verify passwords have been set to something that is at least not a default, or a commonly known Oracle password.

Checking for default passwords
------------------------------

It turns out that Oracle have made it very easy to tell if any users still have their original, default password:

~~~ sql
SELECT *
FROM dba_users_with_defpwd
~~~

Any user that appears in this view hasn't had its default password changed. It's worth noting that most of these users in this view will likely be locked, and they can be easily excluded by constraining the query slightly:

~~~ sql
SELECT *
FROM dba_users_with_defpwd du1
WHERE NOT EXISTS (
  SELECT 1 
  FROM dba_users du2
  WHERE du1.username = du2.username
  AND du2.account_status LIKE '%LOCKED%'
)
~~~

This achieves part of my goal, but doesn't cover users that I've created myself using simple passwords with the intention of later changing them manually, in an unscripted way.

It's arguable that we should have better, more secure passwords in our user creation scripts, but as they're stored in plain text in version control and reused for each database instance we create, this wouldn't really increase security. 

Checking for known passwords
----------------------------

You can view the [full script as a GitHub snippet][7], but here are the key steps.

First, I created a simple table type to contain the passwords I want to look for. I took most of these from Pete Finnigan's [Oracle Default Password List][8].

~~~ plsql
TYPE t_table_of_vc30 IS TABLE OF VARCHAR2(30);

l_base_weak_passwords t_table_of_vc30 := t_table_of_vc30(
  'dev'
, 'dev1'
, 'st'
, 'st1'
, 'uat'
, 'uat1'
[...]
);
~~~

Then, I defined a couple of PL/SQL functions to hash the passwords and create the value I'd expect to find in the `SPARE4` column.

~~~ plsql
-- SHA1 hashes the password mimicking the Oracle implementation 
FUNCTION password_hash (
  p_password VARCHAR2
, p_salt     VARCHAR2
)
RETURN VARCHAR2
IS
BEGIN
  RETURN dbms_crypto.hash(
    src => utl_raw.cast_to_raw(p_password)||hextoraw(p_salt)
  , typ => dbms_crypto.HASH_SH1
  );
END password_hash;

-- Builds up the spare4 column syntax (as per 11g password storage model)
FUNCTION generate_spare4 (
  p_password VARCHAR2
, p_salt     VARCHAR2
)
RETURN VARCHAR2
IS
BEGIN
  RETURN 'S:' || password_hash(p_password, p_salt) || p_salt;
END generate_spare4;
~~~

In the main body of the script, I pad out the password list by adding all of the Oracle usernames to it (in case any user has its username as the password).

~~~ plsql
SELECT username
BULK COLLECT INTO l_username_passwords
FROM dba_users;

l_test_passwords := l_base_weak_passwords MULTISET UNION DISTINCT l_username_passwords;
~~~

Finally, before testing each user's hash in the database, the password combinations are further padded out by upper-casing, lower-casing and sentence-casing them all:

~~~ plsql
-- Lower, upper, initcap each password for some crude variations
FOR idx IN l_test_passwords.FIRST .. l_test_passwords.LAST LOOP
  l_temp.EXTEND(3);
  l_temp(l_temp.COUNT - 2) := LOWER(l_test_passwords(idx));
  l_temp(l_temp.COUNT - 1) := UPPER(l_test_passwords(idx));
  l_temp(l_temp.COUNT) := INITCAP(l_test_passwords(idx));
END LOOP;
~~~

This gives me a decent enough list to then loop through all of the database users, create hashes for each password and see if it matches.

If any users have a password matching one in my list, the username is written out via `DBMS_OUTPUT`, giving me a list of users for which the password should be changed.

Caveat about password complexity
--------------------------------

This script achieves my goal of making sure default / known weak passwords are changed. The main thing it does not do is verify the complexity of the stored passwords, which would only be possible if I turned it into a password cracking script. While relatively trivial, this is way beyond the scope of my needs. 

Oracle does have support for [enforcing password complexity][9] when passwords are set or changed, and I would highly recommend that you use it.

Conclusion
----------

I can quickly run this script on a one-off or repeat basis to perform a bit of basic due dilligence over the Oracle user accounts on any given database. Please let me know if you find it useful.

[1]: http://docs.oracle.com/cd/E11882_01/server.112/e41084/statements_8003.htm#SQLRF01503
[2]: http://en.wikipedia.org/wiki/SHA-1
[3]: http://en.wikipedia.org/wiki/Triple_DES
[4]: http://marcel.vandewaters.nl/oracle/security/password-hashes
[5]: http://www.oradba.ch/2011/02/case-sensitive-passwords-and-strong-user-authentication-2/
[6]: http://askdba.org/weblog/2008/11/how-to-changerestore-user-password-in-11g/
[7]: http://gist.github.com/benbasson/dfbb94e2e0615c87fdff
[8]: http://www.petefinnigan.com/default/default_password_list.htm
[9]: http://docs.oracle.com/cd/E11882_01/network.112/e16543/authentication.htm#DBSEG99811






