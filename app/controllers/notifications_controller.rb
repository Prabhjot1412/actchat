class NotificationsController < ApplicationController
  def accept
    notification_id = params[:notification_id]
    raise 'No ID given' unless notification_id

    Notification.find(notification_id).accept

    render json: { status: :success }
  rescue => e
    render json: { status: :failure, message: e.message }
  end

  def reject
    notification_id = params[:notification_id]
    raise 'No ID given' unless notification_id

    Notification.find(notification_id).reject

    render json: { status: :success }
  rescue => e
    render json: { status: :failure, message: e.message }
  end
end
