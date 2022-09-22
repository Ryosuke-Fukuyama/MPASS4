class HospitalLabel < ApplicationRecord
  has_many :hospital_labelings
  has_many :hospitals, through: :hospital_labelings
end
