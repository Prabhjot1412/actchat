class Notification < ApplicationRecord
  belongs_to :receiver, class_name: 'User'

  enum :kind, %i[friend_request]

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
