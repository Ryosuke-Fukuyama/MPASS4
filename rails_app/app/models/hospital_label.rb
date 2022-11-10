class HospitalLabel < ApplicationRecord
  has_many :hospital_labelings
  has_many :hospitals, through: :hospital_labelings

  validates :name, presence: true,
                   uniqueness: true
end
