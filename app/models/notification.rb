class Notification < ApplicationRecord
  belongs_to :sender, class_name: 'User'

  def receiver
    User.find_by(id: self.receiver_id)
  end

  def receiver=(user)
    self.receiver_id = user.id
  end

  enum :kind, %i[friend_request]
end
