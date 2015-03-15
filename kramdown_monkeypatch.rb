require 'uri'

# Simple Monkey Patch to convert URLs from relative to absolute
# if the option to do so is enabled
class Kramdown::Parser::Kramdown
 
  alias old_add_link add_link
  
  def base_url_as_uri
    @base_url_as_uri ||= URI.parse(@options[:base_url])
  end
  
  def add_link(el, href, title, alt_text = nil, ial = nil)
    if @options[:absolute_urls] and URI.parse(href).relative? 
      href = base_url_as_uri.merge(href).to_s
    end
    old_add_link(el, href, title, alt_text, ial)
  end
 
end