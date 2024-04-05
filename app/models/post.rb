class Post < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  has_one_attached :image

  validate :either_image_or_data_is_present?

  private

  def either_image_or_data_is_present?
    unless self.image.attached? || self.text != ''
      self.errors.add(:post, 'is blank')
    end
  end
end
