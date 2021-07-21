require 'nokogiri'
require 'open-uri'

class Champions
  ADDR = 'https://champions.football.ua/results/'

  def initialize
    @result = []
  end

  def upcoming
    content_rows.each do |tr|
      tr.at('td')['colspan'] ? result << not_match(tr) : result << match(tr)
    end

    result
  end

  private

  attr :result

  def not_match(node)
    node.css('td').text
  end

  def match(node)
    "#{time(node)} #{home_team(node)} #{score(node)} #{guest_team(node)}"
  end

  def time(node)
    node.css('td.time').text
  end

  def home_team(node)
    node.css('td.al_r').text
  end

  def score(node)
    node.css('td.count').text
  end

  def guest_team(node)
    node.css('td.al_l').text
  end

  def page
    URI.open(ADDR)
  end

  def parsed_page
    Nokogiri::HTML(page)
  end

  def content_rows
    parsed_page.css('table.statistic_table tbody tr')
  end
end
