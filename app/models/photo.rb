class Photo < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :image, presence: true
  validate :image_size

  belongs_to :user

  private

  def image_size
    errors.add(:image, 'should be less than 5MB') if image.size > 5.megabytes
  end
end
