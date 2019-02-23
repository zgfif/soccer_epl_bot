# this class is used to return extracted data from required URI

require 'nokogiri'

require 'open-uri'

class LastResult
  attr_reader :site

  def initialize
    @site = 'https://football.ua/england.html'
  end

  def perform
    # this method returns the string of data with new line symbols - \n
    array_of_score.join "\n"
  end

  # private

  def page
    # this method returns the entire page by uri
    @page ||= Nokogiri::HTML.parse open(site)
  end

  def game_feed
    # this method returns the node that contains required data
    page.at_css('article.game-feed')
  end

  def array_of_score
    # this method returns the array of parsed data from basic node
    games_result = []

    game_feed.children.each do |node|
      next if node.is_a? Nokogiri::XML::Text

      node.children.each do |inner|
        next if inner.is_a? Nokogiri::XML::Text

        mmm = ''
        inner.children.each do |el|
          next if el.is_a? Nokogiri::XML::Text
          mmm << el.text.strip + ' '
        end
        games_result << mmm
      end
    end
    games_result
  end
end
