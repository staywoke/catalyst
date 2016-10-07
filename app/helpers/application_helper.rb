module ApplicationHelper
  def active_if(*paths)
    paths.each do |path|
      return 'active' if current_page?(path)
    end
  end
end
