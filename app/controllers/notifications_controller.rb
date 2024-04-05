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

  def fetch_chats
    friend_id = params[:friend_id]
    raise 'no friend id' unless friend_id.present?

    friend = User.find(friend_id)

    notifications = Notification.chats_with(current_user, friend).order(:created_at)
    notifications.update_all(seen: true)

    data = notifications.as_json

    if data.present?
      data.map! do |noti|
        sender = User.find(noti["sender_id"])
        noti["sender_name"] = sender.user_name
        noti["sender_avatar_url"] = url_for(sender.avatar.image)
        noti["sent_by_current?"] = sender == current_user

        noti
      end
    end

    render json: data
  end

  def create
    create_chat_message if params[:kind] == 'chat'
  end

  private

  def broadcast_notification(receiver)
    ActionCable.server.broadcast(
      "notification-#{receiver.id}",
      {notification_count: receiver.notifications.where(seen: false, kind: Notification::VALID_NOTIFICATIONS).count}
    )
  end

  def create_chat_message
    friend_id = params[:friend_id].to_i
    message = params[:data]
    
    return unless message.present?
    Notification.send_message(current_user.id, friend_id, message)

    ActionCable.server.broadcast("chat-#{friend_id}", {
      "avatar_url" => url_for(current_user.avatar.image),
      "message" => message,
      'sender_id' => current_user.id
    })
  end
end
