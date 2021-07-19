require 'httparty'
require 'nokogiri'

class Epl
  ADDR = 'https://football.ua/england.html'

  def initialize
    @result = []
  end

  def recent
    result << tour_and_date

    rows.each do |row|
      result << "#{time(row)} #{home_team(row)} #{score(row)} #{guest_team(row)}"
    end

    result
  end

  private

  attr :result

  def time(row)
    row.css('td.time').text
  end

  def home_team(row)
    row.css('td.left-team').text
  end

  def guest_team(row)
    row.css('td.right-team').text
  end

  def score(row)
    handle_str(row.css('td.score').text)
  end

  def rows
    recent_table.css('tr')
  end

  def tour_and_date
    str = remove_symbols(recent_table.at_css("[colspan='4']").text)
    reduce_spaces(str)
  end

  def recent_table
    parsed_page.css('table.feed-table')[0]
  end

  def parsed_page
    Nokogiri::HTML(page)
  end

  def page
    HTTParty.get(ADDR)
  end

  def handle_str(str)
    str.gsub(/[\s\r\n]/, '')
  end

  def remove_symbols(str)
    str.gsub(/[\r\n\t]/, '')
  end

  def reduce_spaces(str)
    str.split('               ').join('')
  end
end
