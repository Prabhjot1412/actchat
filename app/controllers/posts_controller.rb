class PostsController < ApplicationController
  def create
    current_user.posts.create(create_params)
    flash[:notice] = 'created Successfully'

    redirect_to root_path
  rescue => e
    flash[:alert] = 'some error occured: ' + e.message
    redirect_to root_path
  end

  private

  def create_params
    params.require(:post).permit(:text)
  end
end
