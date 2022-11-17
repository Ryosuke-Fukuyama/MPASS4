# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_11_16_230824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "favorite_hospitals", force: :cascade do |t|
    t.bigint "patient_id"
    t.bigint "hospital_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hospital_id"], name: "index_favorite_hospitals_on_hospital_id"
    t.index ["patient_id"], name: "index_favorite_hospitals_on_patient_id"
  end

  create_table "guide_statuses", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.bigint "health_interview_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["health_interview_id"], name: "index_guide_statuses_on_health_interview_id"
  end

  create_table "health_interviews", force: :cascade do |t|
    t.integer "age"
    t.integer "gender"
    t.text "symptoms"
    t.text "condition"
    t.integer "price"
    t.bigint "patient_id", null: false
    t.bigint "hospital_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hospital_id"], name: "index_health_interviews_on_hospital_id"
    t.index ["patient_id"], name: "index_health_interviews_on_patient_id"
  end

  create_table "hospital_labelings", force: :cascade do |t|
    t.bigint "hospital_id"
    t.bigint "hospital_label_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hospital_id"], name: "index_hospital_labelings_on_hospital_id"
    t.index ["hospital_label_id"], name: "index_hospital_labelings_on_hospital_label_id"
  end

  create_table "hospital_labels", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "tel", null: false
    t.string "address", null: false
    t.string "access"
    t.text "introduction"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "masters", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_masters_on_confirmation_token", unique: true
    t.index ["email"], name: "index_masters_on_email", unique: true
    t.index ["name"], name: "index_masters_on_name", unique: true
    t.index ["reset_password_token"], name: "index_masters_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_masters_on_unlock_token", unique: true
  end

  create_table "patients", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "tel"
    t.string "address"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_patients_on_confirmation_token", unique: true
    t.index ["email"], name: "index_patients_on_email", unique: true
    t.index ["name"], name: "index_patients_on_name"
    t.index ["reset_password_token"], name: "index_patients_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_patients_on_unlock_token", unique: true
  end

  create_table "staffs", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "admin", default: false
    t.bigint "hospital_id"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hospital_id"], name: "index_staffs_on_hospital_id"
    t.index ["name"], name: "index_staffs_on_name", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "favorite_hospitals", "hospitals"
  add_foreign_key "favorite_hospitals", "patients"
  add_foreign_key "guide_statuses", "health_interviews"
  add_foreign_key "health_interviews", "hospitals"
  add_foreign_key "health_interviews", "patients"
  add_foreign_key "hospital_labelings", "hospital_labels"
  add_foreign_key "hospital_labelings", "hospitals"
  add_foreign_key "staffs", "hospitals"
end
