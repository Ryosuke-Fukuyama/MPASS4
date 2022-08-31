class CreateFavoriteHospitals < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_hospitals do |t|
      t.references :patient, foreign_key: true
      t.references :hospital, foreign_key: true

      t.timestamps
    end
  end
end
