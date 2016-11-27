source 'https://rubygems.org'

gem 'thin'
gem 'sinatra'
gem 'sinatra-contrib'
gem 'activesupport'
gem 'haml'
gem 'kramdown'
gem 'coderay', :git => 'https://github.com/benbasson/coderay.git', :branch => 'oracle-sql-plsql'
gem 'preamble', :git => 'https://github.com/benbasson/preamble.git', :branch => 'release', :tag => 'v0.0.3'
gem 'hashugar'
gem 'httparty'
gem 'rack-contrib'

# to deal with cross-platform development issues, currently using forked variant
group :development do
  gem 'git-version-bump', :git => 'https://github.com/benbasson/git-version-bump.git', :branch => 'windows-compatibility', :platform => :mswin
end

group :production do
  gem 'newrelic_rpm'
end
