class OmniauthController < ApplicationController
  skip_before_action :authenticate_user!

  def google_user
    user = User.find_by(email: request.env['omniauth.auth']['info']['email'])

    unless user.present?
      user = create_new_user_google
    end

    sign_in(user)
    redirect_to root_path
  end

  private

  def create_new_user_google
    ActiveRecord::Base.transaction do
      user = User.new(email: request.env['omniauth.auth']['info']['email'], password: SecureRandom.hex(12))
      user.avatar = Avatar.create
      avatar_image = URI.parse(request.env['omniauth.auth']['info']['image']).open
      user.avatar.image.attach(io: avatar_image, filename: "google-avatar-#{SecureRandom.hex(10).to_s}")
      user.save

      user
    end
  end
end
