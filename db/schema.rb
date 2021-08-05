# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_20_053701) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "first_name", limit: 256, null: false
    t.string "last_name", limit: 256
    t.string "mobile_number", limit: 24, null: false
    t.string "email", limit: 256, default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["mobile_number"], name: "index_admin_users_on_mobile_number"
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "client_feedbacks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "client_user_id"
    t.text "input", null: false
    t.text "output", null: false
    t.string "remarks", null: false
    t.string "category"
    t.string "input_language", null: false
    t.string "output_language", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_user_id"], name: "index_client_feedbacks_on_client_user_id"
  end

  create_table "client_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "first_name", limit: 256, null: false
    t.string "last_name", limit: 256
    t.string "position", limit: 256
    t.string "mobile_number", limit: 24, null: false
    t.string "organisation", limit: 256
    t.string "country", limit: 256
    t.string "country_code", limit: 256
    t.string "time_zone", limit: 256
    t.string "email", limit: 256, default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.text "image"
    t.boolean "t_c_accepted"
    t.boolean "flag"
    t.index ["confirmation_token"], name: "index_client_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_client_users_on_email", unique: true
    t.index ["mobile_number"], name: "index_client_users_on_mobile_number"
    t.index ["reset_password_token"], name: "index_client_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_client_users_on_unlock_token", unique: true
  end

  create_table "document_folders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "title", limit: 256, null: false
    t.bigint "parent_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_document_folders_on_ancestry"
    t.index ["user_id"], name: "index_document_folders_on_user_id"
  end

  create_table "identities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "client_user_id"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_user_id"], name: "index_identities_on_client_user_id"
  end

  create_table "label_templates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", limit: 256
    t.string "description", limit: 1024
    t.string "style", limit: 64
    t.text "ltr_html_source"
    t.text "rtl_html_source"
    t.boolean "latest", default: true
    t.bigint "admin_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", limit: 16, default: "ACTIVE", null: false
    t.index ["admin_user_id"], name: "index_label_templates_on_admin_user_id"
  end

  create_table "permissions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "title", limit: 256, null: false
    t.string "route", limit: 256, null: false
    t.string "description", limit: 256, null: false
    t.string "permission_group", limit: 64
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscription_permissions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "title", limit: 256, null: false
    t.bigint "permission_id"
    t.bigint "subscription_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_subscription_permissions_on_permission_id"
    t.index ["subscription_id"], name: "index_subscription_permissions_on_subscription_id"
  end

  create_table "subscriptions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "title", limit: 256, null: false
    t.float "price", default: 0.0
    t.string "status", limit: 16, default: "ACTIVE", null: false
    t.string "description", limit: 256
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "table_document_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "table_document_id"
    t.string "input_phrase", limit: 256, null: false
    t.string "input_language", limit: 16, null: false
    t.string "output_1_phrase", limit: 256
    t.string "output_1_language", limit: 16
    t.bigint "output_1_translation_id"
    t.string "output_2_phrase", limit: 256
    t.string "output_2_language", limit: 16
    t.bigint "output_2_translation_id"
    t.string "output_3_phrase", limit: 256
    t.string "output_3_language", limit: 16
    t.bigint "output_3_translation_id"
    t.string "output_4_phrase", limit: 256
    t.string "output_4_language", limit: 16
    t.bigint "output_4_translation_id"
    t.string "output_5_phrase", limit: 256
    t.string "output_5_language", limit: 16
    t.bigint "output_5_translation_id"
    t.boolean "translated", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["output_1_translation_id"], name: "index_table_document_items_on_output_1_translation_id"
    t.index ["output_2_translation_id"], name: "index_table_document_items_on_output_2_translation_id"
    t.index ["output_3_translation_id"], name: "index_table_document_items_on_output_3_translation_id"
    t.index ["output_4_translation_id"], name: "index_table_document_items_on_output_4_translation_id"
    t.index ["output_5_translation_id"], name: "index_table_document_items_on_output_5_translation_id"
    t.index ["table_document_id"], name: "index_table_document_items_on_table_document_id"
  end

  create_table "table_documents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "title", limit: 256, null: false
    t.string "input_language", limit: 16, null: false
    t.string "output_1_language", limit: 16, null: false
    t.string "output_2_language", limit: 16
    t.string "output_3_language", limit: 16
    t.string "output_4_language", limit: 16
    t.string "output_5_language", limit: 16
    t.string "status", limit: 16, default: "ACTIVE", null: false
    t.boolean "favorite", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "folder_id"
    t.index ["user_id"], name: "index_table_documents_on_user_id"
  end

  create_table "template_documents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "title", limit: 256, null: false
    t.string "input_language", limit: 16, null: false
    t.string "output_language", limit: 16, null: false
    t.string "status", limit: 16, default: "ACTIVE", null: false
    t.text "input_html_source"
    t.text "output_html_source"
    t.boolean "favorite", default: false
    t.bigint "template_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "folder_id"
    t.index ["template_id"], name: "index_template_documents_on_template_id"
    t.index ["user_id"], name: "index_template_documents_on_user_id"
  end

  create_table "translation_query_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.text "input_phrase", null: false
    t.string "input_language", limit: 16, null: false
    t.text "output_phrase", null: false
    t.string "output_language", limit: 16, null: false
    t.boolean "error", default: false
    t.json "error_message"
    t.bigint "client_user_id"
    t.string "doc_type", limit: 256
    t.string "status", limit: 16, default: "ACTIVE", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_user_id"], name: "index_translation_query_histories_on_client_user_id"
  end

  create_table "translation_requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "requested_by_id"
    t.text "input_phrase", null: false
    t.string "input_language", limit: 16, null: false
    t.text "output_phrase"
    t.string "output_language", limit: 16, null: false
    t.string "doc_type", limit: 256
    t.string "status", limit: 16, default: "ACTIVE", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requested_by_id"], name: "index_translation_requests_on_requested_by_id"
  end

  create_table "translations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "input_phrase", limit: 256, null: false
    t.string "input_language", limit: 16, null: false
    t.string "output_phrase", limit: 256, null: false
    t.string "output_language", limit: 16, null: false
    t.string "category", limit: 16
    t.bigint "admin_user_id"
    t.string "status", limit: 16, default: "PENDING", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "input_length", default: 0
    t.index ["admin_user_id"], name: "index_translations_on_admin_user_id"
    t.index ["input_length"], name: "index_translations_on_input_length"
  end

  create_table "uploads_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "admin_user", limit: 256, null: false
    t.string "file_path", limit: 256, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uploads_summaries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "translation_uploads_history_id", null: false
    t.json "summary_new", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_inserted_data"
    t.integer "total_existing_data"
    t.integer "total_error_data"
  end

  create_table "user_subscriptions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "subscription_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_id"], name: "index_user_subscriptions_on_subscription_id"
    t.index ["user_id"], name: "index_user_subscriptions_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "identities", "client_users"
  add_foreign_key "label_templates", "admin_users"
  add_foreign_key "subscription_permissions", "permissions", on_delete: :cascade
  add_foreign_key "subscription_permissions", "subscriptions", on_delete: :cascade
  add_foreign_key "table_documents", "client_users", column: "user_id", on_delete: :cascade
  add_foreign_key "template_documents", "client_users", column: "user_id", on_delete: :cascade
  add_foreign_key "user_subscriptions", "client_users", column: "user_id", on_delete: :cascade
  add_foreign_key "user_subscriptions", "subscriptions", on_delete: :cascade
end
