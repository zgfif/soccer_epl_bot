require 'httparty'
require 'nokogiri'

class Epl
  ADDR = 'https://football.ua/england.html'

  def initailize
  end

  def recent
    result = []

    page = HTTParty.get(ADDR)

    # p page

    parsed_page = Nokogiri::HTML(page)

    # p parsed_page

    recent_table = parsed_page.css('table.feed-table')[0]

    rows = recent_table.css('tr')
    tour_and_date = remove_symbols(recent_table.at_css("[colspan='4']").text)

    result << tour_and_date.split('               ').join('')

    rows.each do |row|
      time = row.css('td.time').text
      home_team = row.css('td.left-team').text
      guest_team = row.css('td.right-team').text
      score = handle_str(row.css('td.score').text)

      result << "#{time} #{home_team} #{score} #{guest_team}"
    end

    result
  end


  private

  def handle_str(str)
    str.gsub(/[\s\r\n]/, '')
  end

  def remove_symbols(str)
    str.gsub(/[\r\n\t]/, '')
  end
end
