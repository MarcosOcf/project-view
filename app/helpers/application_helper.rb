module ApplicationHelper
  def kramdown file
    Kramdown::Document.new(file, input: "GFM").to_html
  end
end
