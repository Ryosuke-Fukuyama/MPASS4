class Hospital < ApplicationRecord
  has_many :staffs, dependent: :destroy
  has_many :hospital_labelings, dependent: :destroy
  has_many :hospital_labels, through: :hospital_labelings, dependent: :nullify
  has_many :favorite_hospitals, dependent: :destroy
  has_many :health_interviews, dependent: :destroy
  # mount_uploader :image, ImageUploader
  accepts_nested_attributes_for :staffs

  include EmailValidates
  include TelValidates
  include AddressValidates

  validates :name, presence: true,
                   length: { maximum: 99 }

  # after_validation :geocode, if: :address_changed?

  # geocoded_by :address
end
