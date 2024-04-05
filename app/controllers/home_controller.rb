class HomeController < ApplicationController
  before_action :set_notifications

  def landing
    @post = current_user.posts.new
  end

  def profile ; end

  def personel ; end

  def public
    @user = User.find_by(id: params[:id])
  end

  def notifications
    @notifications.update_all(seen: true)
  end

  def friends_list ; end

  def chats
  end

  private

  def set_notifications
    @notifications = current_user.notifications
  end
end
