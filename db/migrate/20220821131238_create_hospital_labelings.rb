class CreateHospitalLabelings < ActiveRecord::Migration[6.0]
  def change
    create_table :hospital_labelings do |t|
      t.references :hospital, foreign_key: true
      t.references :hospital_label, foreign_key: true

      t.timestamps
    end
  end
end
