class CreateHospitals < ActiveRecord::Migration[6.0]
  def change
    create_table :hospitals do |t|
      t.string :name,    null: false
      t.string :email,   null: false
      t.string :tel,     null: false
      t.string :address, null: false
      t.string :access
      # t.text :image
      t.text :introduction

      t.timestamps
    end
  end
end
