class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy, foreign_key: :owner_id
  has_one :user_detail, dependent: :destroy
  has_one :user_avatar
  has_one :avatar, through: :user_avatar

  after_create :create_user_details, :set_default_avatar

  def user_name
    self.user_detail.user_name
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
    return if self.avatar.present?

    self.avatar = Avatar.first
  end
end
