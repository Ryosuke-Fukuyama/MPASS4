class CreateHealthInterviews < ActiveRecord::Migration[6.0]
  def change
    create_table :health_interviews do |t|
      t.integer :age
      t.integer :gender
      t.text :symptoms
      t.text :condition
      t.integer :price
      # t.boolean :notification, default: false
      t.references :patient, null: false, foreign_key: true
      t.references :hospital, null: false, foreign_key: true

      t.timestamps
    end
  end
end
