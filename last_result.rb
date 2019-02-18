require 'nokogiri'

require 'open-uri'

class LastResult
  attr_reader :site

  def initialize
    @site = 'https://football.ua/england.html'
  end

  def perform
    array_of_score.join "\n"
  end

  def page
    @page ||= Nokogiri::HTML(open(site))
  end

  def game_feed
    page.at_css('article.game-feed')
  end

  def array_of_score
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