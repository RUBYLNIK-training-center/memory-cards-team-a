module BoardHelper
  def my_title(page_title = '')
    base_title = 'MemoryCardTeamA'
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title.to_s
    end
  end
end
