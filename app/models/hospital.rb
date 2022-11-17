class Hospital < ApplicationRecord
  has_many :staffs, dependent: :delete_all # staffの before_destroyを回避する為
  has_many :hospital_labelings, dependent: :destroy
  has_many :hospital_labels, through: :hospital_labelings
  has_many :favorite_hospitals, dependent: :destroy
  has_many :health_interviews, dependent: :destroy
  has_many_attached :images
  accepts_nested_attributes_for :staffs

  validates :name, presence: true,
                   length: { maximum: 99 }
  include EmailValidates
  include TelValidates
  validates :tel, presence: true
  include AddressValidates
  validates :address, presence: true
  validate :image_type,
            :image_size,
            :image_length

  # after_validation :geocode, if: :address_changed?

  # geocoded_by :address

  def image_type
    images.each do |image|
      if !image.blob.content_type.in?(%('image/jpg image/jpeg image/png'))
        errors.add(:images, :type_validate)
      end
    end
  end
  def image_size
    images.each do |image|
      if image.blob.byte_size > 100000
        errors.add(:images, :size_validate)
      end
    end
  end
  def image_length
    if images.length > 5
      errors.add(:images, :length_validate)
    end
  end
end
