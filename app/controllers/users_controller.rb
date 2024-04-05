class UsersController < ApplicationController
  def fetch_users
    data = Users::Fetch.call(user: current_user, q: params[:q]) {|img| url_for(img)}

    render json: data
  end
end
