require 'nokogiri'

require 'open-uri'

class LastResult
  attr_reader :site

  def initialize
    @site = 'https://football.ua/england.html'
  end

  def perform
    match_time + ' ' + home_team + ' ' + score + ' ' + guest_team
  end

  def page
    @page ||= Nokogiri::HTML(open(site))
  end

  def match_time
    page.at_css('td.time').text
  end

  def home_team
    page.at_css('td.left-team').text
  end

  def score
    unhandled_score.gsub(/\n|\r/, '').strip
  end

  def guest_team
    page.at_css('td.right-team').text
  end

  def unhandled_score
    page.at_css('td.score.ended a').text
  end
end
