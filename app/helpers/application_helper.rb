module ApplicationHelper
  def kramdown file
    require 'kramdown'
    Kramdown::Document.new(file, input: "GFM").to_html
  end
end
