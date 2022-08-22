class CreateHospitalLabels < ActiveRecord::Migration[6.0]
  def change
    create_table :hospital_labels do |t|
      t.string :name

      t.timestamps
    end
  end
end
