module Users
  class Fetch
    class << self
      def call(user:, q:, per: 5, &url_for)
        data = User.includes(:user_detail)
          .where(id: UserDetail.where('user_name like ?', "%#{q}%").first(per).pluck(:user_id))
          return false unless data.present?

          data.each_with_object({}) do |user, obj|
            obj[user.id] = user.as_json
            obj[user.id]["user_name"] = user.user_name
            obj[user.id]["avatar_url"] = url_for.call(user.avatar.image)
          end
      end
    end
  end
end
