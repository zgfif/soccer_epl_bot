require 'nokogiri'
require 'open-uri'

class Resource
  def initialize
    @result = []
  end

  private

  attr :result

  def page
    URI.open(url)
  end

  def parsed_page
    Nokogiri::HTML(page)
  end

  def addr
    nil
  end

  def content_rows
    parsed_page.at_css(content_rows_selector).css('tr')
  end

  def content_rows_selector
    nil
  end
end
