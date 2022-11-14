class FavoriteHospital < ApplicationRecord
  belongs_to :patient
  belongs_to :hospital
end
