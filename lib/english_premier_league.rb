require_relative 'resource'
require_relative 'clearable'
require_relative 'row'

class EnglishPremierLeague < Resource
  include Clearable
  # returns last played EPL football matches
  def recent
    content_rows.each do |row|
      date_of_match?(row) ? result << date_of_match(row) : result << match(row)
    end

    result
  end

  private

  def content_rows_selector
    'table.feed-table'
  end

  def url
    'https://football.ua/england.html'
  end

  def date_of_match?(node)
    node.css('th').any?
  end

  def date_of_match(node)
    str = Row.new(node).text('th p')
    truncate_spaces(str)
  end

  def match(node)
    row = Row.new(node)
    row.text('td.time') + ' ' + row.text('td.left-team a') + ' ' + clear_multiple_spaces(row.text('td.ended a')) + ' ' + row.text('td.right-team a')
  end
end
