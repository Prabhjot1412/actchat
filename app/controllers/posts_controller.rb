class PostsController < ApplicationController
  def create
    post = current_user.posts.new(create_params)
    post.save!
    flash[:notice] = 'created Successfully'

    redirect_to root_path
  rescue => e
    flash[:alert] = post.errors.full_messages&.first || e.message
    redirect_to root_path
  end

  private

  def create_params
    params.require(:post).permit(:text, :image)
  end
end
