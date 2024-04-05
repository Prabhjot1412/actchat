module Posts
  class Fetch
    class << self
      def call(type:, user:, page:, &url_for)
        return fetch_posts(user, page, url_for) unless type.present?
        return fetch_personel_posts(user, page, url_for)
      end

      private

      def fetch_posts(user, page, url_for)
        data = Post.order(created_at: :desc).page(page)
        fetch_data(data, url_for)
      end

      def fetch_personel_posts(user, page, url_for)
        data = Post.where(owner_id: user.id).order(created_at: :desc).page(page)

        fetch_data(data, url_for)
      end

      def fetch_data(data, url_for)
        data.each_with_object({}) do |post, obj|
          obj[post.id] = post.as_json
          obj[post.id]["image_attached"] = post.image.attached?
          obj[post.id]["owner_name"] = post.owner.user_name

          if obj[post.id]["image_attached"]
            obj[post.id]["image_url"] = url_for.call(post.image)
          end

          obj[post.id]["avatar_url"] = url_for.call(post.owner.avatar.image)
        end
      end
    end
  end
end
