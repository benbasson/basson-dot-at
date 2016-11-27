require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'
require 'kramdown'
require 'active_support/all'

require_relative 'models/init'
require_relative 'kramdown_monkeypatch'

configure :production do
  require 'newrelic_rpm'
end

configure do
  
  set :haml, :attr_wrapper => '"'
  set :server, 'thin'
  set :sitename, 'Ben Basson'
  set :static_cache_control, [:public, max_age: 60 * 60 * 24 * 7]

  # Pick up all the blog posts and stick them in a hash, which is subsequently
  # date ordered. This allows quick retrival as well as useful traversal
  def parse_content klass, path_wildcard, &get_key 
    content_hash = Hash.new
    Dir[path_wildcard].each do |filepath|
      content_provider = klass.new filepath
      content_hash[get_key.call filepath, content_provider] = content_provider
    end
    return content_hash
  end
  
  # Simple lambdas to create Hash keys
  filename_key = lambda{|filepath, content_provider| File.basename filepath, '.*'} 
  shortname_key = lambda{|filepath, content_provider| content_provider.metadata.shortname}
  
  set :simplepages, parse_content(ContentProvider, './content/simplepages/*.md', &filename_key)
  set :specialpages, parse_content(ContentProvider, './content/specialpages/*.md', &filename_key)
  set :articles, Hash[parse_content(ContentProvider, './content/blog/*.md', &shortname_key).sort_by{|k,v| v.metadata.date}.reverse]
  set :addons, parse_content(AddonContentProvider, './content/addons/*.md', &shortname_key)
  
end

helpers do
  # Helper for nav panel to show active page
  def active? path = ''
    request.path_info == "/#{path}" ? 'active' :
      request.path_info.match(/\/#{path}\/[a-zA-Z]*/).nil? ? nil : 'active'
  end
  
  # Simple helper for 
  def request_port
    '' if request.scheme == 'http' and request.port == 80
    ":#{request.port}"
  end
  
  # Provides the absolute (base) URL that was requested so that it
  # can be prepended to relative links where necessary
  def base_url 
    "#{request.scheme}://#{request.host}#{request_port}"
  end
end

# Special cased routes using bespoke views
['/', '/home/?'].each do |path|
  get path do
    @page = settings.specialpages['home']
    @include_rss = true
    haml :home
  end
end

get '/blog/?' do
  @page = settings.specialpages['blog']
  @include_rss = true
  haml :blog
end

# Simplest RSS feed implementation ever!
get '/rss/?' do
  content_type 'application/rss+xml'
  @page = settings.specialpages['blog']
  haml :rss, :layout => false, :format => :xhtml
end

# Generate routes for all "simple" pages
settings.simplepages.each do |page_name, page_content|
  get "/#{page_name}/?" do
    @page = page_content
    haml :simplepage
  end
end

# Generate routes for blog articles
settings.articles.each do |article_name, article_content|
  get "/blog/#{article_name}/?" do
    @page = article_content
    @include_rss = true
    @comments_enabled = true
    haml :simplepage
  end
end

# Generate routes for addons
settings.addons.each do |addon_name, addon_content|
  get "/firefox-addons/#{addon_name}/?" do
    @page = addon_content
    haml :addon
  end
end

not_found do
  status 404
  @page = settings.simplepages['404']
  haml :simplepage
end

get '/service-status/?' do
  "Up and running: #{Time.now.to_formatted_s :db}" 
end