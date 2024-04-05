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
    if params[:notification_id]
      notification_id = params[:notification_id]
    elsif params[:sender_id] && params[:receiver_id]
      notification_id = Notification.find_by(
                                              kind: 'friend_request',
                                              sender_id: params[:sender_id],
                                              receiver_id: params[:receiver_id],
                                            ).id
    end

    raise 'No ID given' unless notification_id

    Notification.find(notification_id).reject

    render json: { status: :success }
  rescue => e
    render json: { status: :failure, message: e.message }
  end

  def send_notification
    raise 'no sender or receiver id' unless params[:sender_id] || params[:receiver_id]
    sender = User.find(params[:sender_id])
    sender.send_friend_request_to(User.find(params[:receiver_id]))

    render json: { status: :success }
  rescue => e
    render json: { status: :failure, message: e.message }
  end
end
