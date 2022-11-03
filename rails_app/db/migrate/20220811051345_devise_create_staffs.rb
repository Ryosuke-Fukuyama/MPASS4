# frozen_string_literal: true

class DeviseCreateStaffs < ActiveRecord::Migration[6.0]
  def change
    create_table :staffs do |t|
      ## Database authenticatable
      t.string :name,               null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.boolean :admin,             default: false

      t.references :hospital, foreign_key: true

      ## Recoverable
      # t.string   :reset_password_token
      # t.datetime :reset_password_sent_at

      ## Rememberable
      # t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.timestamps null: false
    end

    add_index :staffs, :name, unique: true
    # add_index :staffs, :reset_password_token, unique: true
    # add_index :staffs, :confirmation_token,   unique: true
    # add_index :staffs, :unlock_token,         unique: true
  end
end
