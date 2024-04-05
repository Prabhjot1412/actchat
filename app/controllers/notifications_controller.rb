class NotificationsController < ApplicationController
  def accept
    notification_id = params[:notification_id]
    raise 'No ID given' unless notification_id

    Notification.find(notification_id).accept
    broadcast_notification(current_user)

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

    receiver_id = Notification.find(notification_id).receiver_id
    Notification.find(notification_id).reject

    broadcast_notification(User.find_by(id: receiver_id))
    render json: { status: :success }
  rescue => e
    render json: { status: :failure, message: e.message }
  end

  def send_notification
    raise 'no sender or receiver id' unless params[:sender_id] || params[:receiver_id]
    sender = User.find(params[:sender_id])
    receiver = User.find(params[:receiver_id])
    sender.send_friend_request_to(receiver)
    broadcast_notification(receiver)

    render json: { status: :success }
  rescue => e
    render json: { status: :failure, message: e.message }
  end

  private

  def broadcast_notification(receiver)
    ActionCable.server.broadcast("notification-#{receiver.id}", {notification_count: receiver.notifications.count})
  end
end
