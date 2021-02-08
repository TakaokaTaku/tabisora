module ApplicationHelper
  def full_title(page_title)
    if page_title.blank?
      "TABISORA"
    else
      "#{page_title} | #{TABISORA}"
    end
  end
end
