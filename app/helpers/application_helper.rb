module ApplicationHelper
  def full_title(page_title = '')
    base_title = "ICCCG"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    nil
  end
end
