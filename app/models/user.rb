class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy, foreign_key: :owner_id
  has_many :notifications, dependent: :destroy, foreign_key: :receiver_id

  has_one :user_detail, dependent: :destroy
  has_one :user_avatar
  has_one :avatar, through: :user_avatar

  after_create :create_user_details, :set_default_avatar

  validates :email, uniqueness: true

  def user_name
    self.user_detail.user_name
  end

  def befriend(user)
    raise "invalid argument #{user}" unless user.is_a?(User)

    self.friends_list[user.id] = user.email
    user.friends_list[self.id] = self.email

    self.save!
    user.save!
  end

  def friends
    User.where(id: self.friends_list.keys)
  end

  def unfriend(user)
    raise "invalid argument #{user}" unless user.is_a?(User)

    self.friends_list.delete(user.id.to_s)
    user.friends_list.delete(self.id.to_s)

    self.save!
    user.save!
  end

  def friends_with?(user)
    self.friends.find_by(id: user.id).present?
  end

  def send_friend_request_to(user)
    raise "invalid argument #{user}" unless user.is_a?(User)

    user.notifications.create!(kind: :friend_request, sender: self)
  end

  private

  def create_user_details
    return if  UserDetail.find_by_user_id(self.id).present?

    user_details =  UserDetail.create!(
      user_id:   self.id,
      user_name: self.email.split('@').first
    )
  end

  def set_default_avatar
    return if self.avatar&.image&.attached?

    self.avatar = Avatar.create
    self.avatar.image.attach(io: File.open("#{Rails.root}/app/assets/images/default-avatar.png"), filename: 'default-avatar.png', content_type: 'image/png')
  end
end
