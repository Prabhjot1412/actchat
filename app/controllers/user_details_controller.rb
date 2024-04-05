class UserDetailsController < ApplicationController
  def update    
    current_user.user_detail.update(update_params)
    flash[:notice] = 'updated Successfully'

    redirect_to home_profile_path
  rescue => e
    flash[:alert] = 'some error occured: ' + e.message
    redirect_to home_profile_path
  end

  private

  def update_params
    params.require(:user_detail).permit(:user_name)
  end
end
