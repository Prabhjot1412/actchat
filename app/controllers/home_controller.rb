class HomeController < ApplicationController
  def landing
    @post = current_user.posts.new
  end

  def profile ; end

  def personel ; end
end
