module Clearable
  def clear_symbols(str)
    str.gsub(/[\n\r]/ , '')
  end

  def truncate_spaces(str)
    clear_symbols(str).gsub(/\s{2,}/, ' ')
  end

  def clear_multiple_spaces(str)
    clear_symbols(str).gsub(/\s{2,}/, '')
  end
end
