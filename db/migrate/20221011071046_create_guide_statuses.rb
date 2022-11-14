class CreateGuideStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :guide_statuses do |t|
      t.integer :status,              null: false, default: 0
      t.references :health_interview, null: false, foreign_key: true

      t.timestamps
    end
  end
end
