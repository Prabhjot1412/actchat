class AvatarsController < ApplicationController
  def update    
    current_user.avatar.update(update_params)
    flash[:notice] = 'updated Successfully'

    redirect_to home_profile_path
  rescue => e
    flash[:alert] = 'some error occured: ' + e.message
    redirect_to home_profile_path
  end

  private

  def update_params
    params.require(:avatar).permit(:image)
  end
end
