class Hospital < ApplicationRecord
  has_many :staffs, dependent: :destroy
  # has_many :health_interviews, dependent: :destroy
  # has_many :hospital_labelings, dependent: :destroy
  # has_many :hospital_labels, through: :hospital_labelings
  # has_many :favorite_hospitals, dependent: :destroy
  # accepts_nested_attributes_for :staffs
  # mount_uploader :image, ImageUploader

  include EmailValidates
  include TelValidates
  include AddressValidates

  validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 99 }

  # after_validation :geocode, if: :address_changed?

  # geocoded_by :address
end
