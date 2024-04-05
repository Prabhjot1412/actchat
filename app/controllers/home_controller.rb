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

  def notifications ; end

  private

  def set_notifications
    @notifications = current_user.notifications
  end
end
