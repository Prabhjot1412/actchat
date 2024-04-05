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
    data = Post.page(params[:page_id]).per(2)

    data = data.each_with_object({}) do |post, obj|
      obj[post.id] = post.as_json
      obj[post.id]["image_attached"] = post.image.attached?
      obj[post.id]["owner_name"] = post.owner.user_name

      if obj[post.id]["image_attached"]
        obj[post.id]["image_url"] = url_for(post.image)
      end

      obj[post.id]["avatar_url"] = url_for(post.owner.avatar.image)
    end

    render json: data
  end

  private

  def create_params
    params.require(:post).permit(:text, :image)
  end
end
