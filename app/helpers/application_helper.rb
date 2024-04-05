module ApplicationHelper
  def base_path
    return 'http://localhost:3000/' if Rails.env == 'development'
  end
end
