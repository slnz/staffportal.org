module ApplicationHelper
  def title(page_title, options = {})
    content_for(:title, page_title.to_s)
    content_tag(:h1, page_title, options)
  end

  def flash_class(level)
    case level
    when :notice then 'alert alert-info'
    when :success then 'alert alert-success'
    when :error then 'alert alert-error'
    when :alert then 'alert alert-error'
    end
  end
end
