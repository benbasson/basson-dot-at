require 'hashugar'
require 'preamble'

class ContentProvider
  
  attr_accessor :metadata, :content
  
  def initialize filepath
    preamble = Preamble.load filepath, {:external_encoding => 'UTF-8'}
    @content = preamble.content
    @metadata = preamble.metadata.to_hashugar
  end
  
  def headtitle
    return (@metadata.headtitle === '!nil') ? "" 
      : (not @metadata.headtitle.nil?) ? " - #{@metadata.headtitle}" 
      : (not @metadata.title.nil?) ? " - #{@metadata.title}"
      : ""
  end
  
  def formatted_date
    @metadata.date.strftime "#{@metadata.date.day.ordinalize} %B %Y %H:%M"
  end
  
  def include_date_and_author?
    not @metadata.author.nil? and not @metadata.date.nil?
  end
  
end
