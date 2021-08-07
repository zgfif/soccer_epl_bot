class Row
  def initialize(node)
    @node = node
  end

  def text(selector)
    node.at_css(selector).text
  end

  private

  attr :node
end
