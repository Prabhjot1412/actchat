class Post < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  has_one_attached :image
  has_many :likes, as: :likeable

  validate :either_image_or_data_is_present?

  def vote(user, value)
    like = self.likes.find_by(user_id: user.id)

    if like.present?
      like.update(like: value)
    else
      self.likes.create(user_id: user.id, like: value)
    end
  end

  def unlike(user)
    self.likes.find_by(user_id: user.id).destroy
  end

  def like_value(user)
    like = self.likes.find_by(user_id: user.id)
    return 0 unless like.present?

    like.like
  end

  def likes_count
    self.likes.sum(:like)
  end

  private

  def either_image_or_data_is_present?
    unless self.image.attached? || self.text != ''
      self.errors.add(:post, 'is blank')
    end
  end
end
