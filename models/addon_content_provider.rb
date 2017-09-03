require 'httparty'
require 'json'
require_relative 'content_provider'

class AddonContentProvider < ContentProvider
 
  include HTTParty

  attr_accessor :addon_data, :github_versions

  def initialize filepath
    super filepath 

    # Pull data from the Mozilla Add-ons site  
    amo_data = AddonContentProvider.get("https://services.addons.mozilla.org/en-US/firefox/api/1.5/addon/#{@metadata.addonid}")

    client_id = ENV['GITHUB_CLIENT_ID'] || File.read('.github-client-id')
    client_secret = ENV['GITHUB_CLIENT_SECRET'] || File.read('.github-client-secret')

    # Pull data from GitHub releases 
    github_versions = AddonContentProvider.get("https://api.github.com/repos/#{@metadata.githubrepo}/releases?client_id=#{client_id}&client_secret=#{client_secret}", {
      # GitHub API mandates that UserAgent must be sent
      :headers => {"User-Agent" => 'HTTParty (basson.at)', "Accept" => 'application/json'}
    })

    # Convert everything to Hashugar objects for easy referencing
    @addon_data = amo_data['addon'].to_hashugar
    @github_versions = JSON.parse(github_versions.body).to_hashugar
    
    # As this has nested content, need to dereference 
    @addon_data.install = @addon_data.install.__content__
  end
    
end