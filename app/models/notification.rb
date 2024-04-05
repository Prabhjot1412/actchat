class Notification < ApplicationRecord
  VALID_NOTIFICATIONS = ['friend_request']

  has_rich_text :content

  belongs_to :receiver, class_name: 'User'

  enum :kind, %i[friend_request chat]

  scope :chats_with, ->(user, friend) { 
    where(
      kind: 'chat',
      sender_id: friend.id,
      receiver_id: user.id,
    ).or(
      Notification.where(
        kind: 'chat',
        receiver_id: friend.id,
        sender_id: user.id,
      )
    )
  }

  def sender
    User.find_by(id: self.sender_id)
  end

  def sender=(user)
    self.sender_id = user.id
  end

  def accept
    accept_friend_request if self.kind == 'friend_request'
  end

  def reject
    self.destroy if self.kind == 'friend_request'
  end

  private

  def accept_friend_request
    self.sender.befriend(self.receiver)

    self.destroy
  end
end
