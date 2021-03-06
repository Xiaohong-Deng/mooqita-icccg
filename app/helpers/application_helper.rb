module ApplicationHelper
  def full_title(page_title = '')
    base_title = "ICCCG"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def flash_class(level)
    case level
    when 'notice' then "alert alert-success"
    when 'success' then "alert alert-success"
    when 'info' then "alert alert-info"
    when 'error' then "alert alert-warning"
    when 'alert' then "alert alert-danger"
    end
  end

  def markdown_to_html(text)
    Kramdown::Document.new(text, input: 'GFM').to_html
  end
end
