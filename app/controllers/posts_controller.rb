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
    user = params[:id].present? ? User.find_by(id: params[:id]) : current_user
    data = ::Posts::Fetch.call(type: params[:type], user: user, page: params[:page_id]) {|img| url_for(img)}

    render json: data
  end

  def vote
    raise 'type or id is empty' unless params[:type].present? && params[:post_id].present?

    value = params[:type] == 'like' ? 1 : -1
    Post.find(params[:post_id]).vote(current_user, value)
  end

  def unlike
    raise 'id is empty' unless params[:post_id].present?

    Post.find(params[:post_id]).unlike(current_user)
  end

  private

  def create_params
    params.require(:post).permit(:text, :image)
  end
end
