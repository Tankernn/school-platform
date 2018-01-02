module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "School Platform"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def format_content(text)
    simple_format(text).gsub(/([A-z]+:[^\s<]+)/, '<a href="\0">\0</a>').html_safe
  end
end
