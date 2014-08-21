module TabsHelper

  def tab_css_class tab
    tab.id == @tab.id ? "checked" : ""
  end

end
