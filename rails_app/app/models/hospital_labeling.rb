class HospitalLabeling < ApplicationRecord
  belongs_to :hospital
  belongs_to :hospital_label
end
