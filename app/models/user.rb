class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_detail, dependent: :destroy

  after_create :create_user_details

  def create_user_details
    return if  UserDetail.find_by_user_id(self.id).present?

    user_details =  UserDetail.create!(
      user_id:   self.id,
      user_name: self.email.split('@').first
    )
  end
end
