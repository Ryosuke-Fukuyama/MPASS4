class Hospital < ApplicationRecord
  has_many :staffs, dependent: :destroy
  has_many :hospital_labelings, dependent: :destroy
  has_many :hospital_labels, through: :hospital_labelings, dependent: :nullify
  has_many :favorite_hospitals, dependent: :destroy
  has_many :health_interviews, dependent: :destroy
  # mount_uploader :image, ImageUploader
  accepts_nested_attributes_for :staffs

  validates :name, presence: true,
                   length: { maximum: 99 }
  include EmailValidates
  include TelValidates
  validates :tel, presence: true
  include AddressValidates
  validates :address, presence: true

  # after_validation :geocode, if: :address_changed?

  # geocoded_by :address
end
