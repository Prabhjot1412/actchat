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

  def fetch_posts
    data = ::Posts::Fetch.call(type: params[:type], user: current_user, page: params[:page_id]) {|img| url_for(img)}

    render json: data
  end

  private

  def create_params
    params.require(:post).permit(:text, :image)
  end
end
