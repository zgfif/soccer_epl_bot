# this class is used to return extracted data from required URI

require 'nokogiri'

require 'open-uri'

class ChampionsResult
  attr_reader :site

  def initialize
    @site = 'https://champions.football.ua/results/'
  end

  def perform
    # this method returns the string of data with new line symbols - \n
    handle_score.join "\n"
  end

  # private

  def page
    # this method returns the entire page by uri
    @page ||= Nokogiri::HTML.parse open(site)
  end

  def game_feed
  #   # this method returns the node that contains required data
    page.at_css('div#content3')

  end

  def array_of_score
    # this method returns the array of parsed data from basic node
    score = []

    game_feed.children.each do |el|
      next if el.is_a? Nokogiri::XML::Text

      el.children.each do |va|
        next if va.is_a? Nokogiri::XML::Text

        va.children.each do |tt|
          next if tt.is_a? Nokogiri::XML::Text

          tt.children.each do |inner|
            next if inner.is_a? Nokogiri::XML::Text

            inner.children.each do |ch|
              next if ch.is_a? Nokogiri::XML::Text

              score << ch.text
            end
          end
        end
      end
    end
    score
  end

  def handle_score
    arr = array_of_score.map { |el| el.gsub(/\s+/, ' ').strip }

    arr.map { |el| el.match?(' Подробнее') ? el.gsub(' Подробнее', '') : el }
  end
end
