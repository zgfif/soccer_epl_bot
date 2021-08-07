require_relative 'resource'
require_relative 'row'

class ChampionsLeague < Resource
  #returns upcomming Champions League football matches
  def upcoming
    content_rows.each do |tr|
      not_match?(tr) ? result << not_match(tr) : result << match(tr)
    end

    result
  end

  private

  def content_rows_selector
    'table.statistic_table tbody'
  end

  def url
    'https://champions.football.ua/results/'
  end

  def not_match?(tr)
    tr.at('td')['colspan']
  end

  def not_match(node)
    Row.new(node).text('td')
  end

  def match(node)
    row = Row.new(node)
    row.text('td.time') + ' ' + row.text('td.al_r') + ' ' + row.text('td.count') + ' ' + row.text('td.al_l')
  end
end
