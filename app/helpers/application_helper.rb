module ApplicationHelper
  def e(text)
    "'#{escape_javascript(text)}'".html_safe
  end
end
