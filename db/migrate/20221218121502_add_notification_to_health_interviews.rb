class AddNotificationToHealthInterviews < ActiveRecord::Migration[6.1]
  def change
    add_column :health_interviews, :notification, :boolean, default: false, null: false
  end
end
