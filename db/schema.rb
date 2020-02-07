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

ActiveRecord::Schema.define(version: 2020_01_28_065106) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
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

  create_table "client_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name", limit: 256, null: false
    t.string "last_name", limit: 256
    t.string "mobile_number", limit: 24, null: false
    t.string "organisation", limit: 256
    t.string "country", limit: 256
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
    t.index ["confirmation_token"], name: "index_client_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_client_users_on_email", unique: true
    t.index ["mobile_number"], name: "index_client_users_on_mobile_number"
    t.index ["reset_password_token"], name: "index_client_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_client_users_on_unlock_token", unique: true
  end

  create_table "document_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "document_id"
    t.string "input_phrase", limit: 256, null: false
    t.string "input_language", limit: 16, null: false
    t.string "output_1_phrase", limit: 256
    t.string "output_1_language", limit: 16
    t.string "output_2_phrase", limit: 256
    t.string "output_2_language", limit: 16
    t.string "output_3_phrase", limit: 256
    t.string "output_3_language", limit: 16
    t.string "output_4_phrase", limit: 256
    t.string "output_4_language", limit: 16
    t.string "output_5_phrase", limit: 256
    t.string "output_5_language", limit: 16
    t.boolean "translated", default: false
    t.bigint "translation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_document_items_on_document_id"
    t.index ["translation_id"], name: "index_document_items_on_translation_id"
  end

  create_table "documents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", limit: 256, null: false
    t.string "description", limit: 1024, null: false
    t.string "input_language", limit: 16, null: false
    t.string "output_1_language", limit: 16, null: false
    t.string "output_2_language", limit: 16
    t.string "output_3_language", limit: 16
    t.string "output_4_language", limit: 16
    t.string "output_5_language", limit: 16
    t.string "status", limit: 16, default: "ACTIVE", null: false
    t.string "type", limit: 128
    t.text "input_html_source"
    t.text "output_html_source"
    t.bigint "template_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_id"], name: "index_documents_on_template_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "documents_tags", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "document_id"
    t.bigint "tag_id"
    t.index ["document_id"], name: "index_documents_tags_on_document_id"
    t.index ["tag_id"], name: "index_documents_tags_on_tag_id"
  end

  create_table "identities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "client_user_id"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_user_id"], name: "index_identities_on_client_user_id"
  end

  create_table "label_templates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 256
    t.string "description", limit: 1024
    t.string "style", limit: 64
    t.text "ltr_html_source"
    t.text "rtl_html_source"
    t.bigint "admin_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_user_id"], name: "index_label_templates_on_admin_user_id"
  end

  create_table "nutrition_facts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", limit: 256
    t.string "sub_title", limit: 256
    t.string "input_langage", limit: 256, null: false
    t.string "output_language", limit: 256, null: false
    t.integer "total_weight"
    t.integer "total_quantity"
    t.integer "serving_size"
    t.integer "no_of_servings"
    t.integer "total_calories"
    t.string "footer", limit: 1024
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nutrition_facts_tags", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "nutrition_fact_id"
    t.bigint "tag_id"
    t.index ["nutrition_fact_id"], name: "index_nutrition_facts_tags_on_nutrition_fact_id"
    t.index ["tag_id"], name: "index_nutrition_facts_tags_on_tag_id"
  end

  create_table "tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 256, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "translations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "input_phrase", limit: 256, null: false
    t.string "input_language", limit: 16, null: false
    t.string "output_phrase", limit: 256, null: false
    t.string "output_language", limit: 16, null: false
    t.string "category", limit: 16
    t.bigint "admin_user_id"
    t.string "status", limit: 16, default: "PENDING", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_user_id"], name: "index_translations_on_admin_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "documents", "client_users", column: "user_id", on_delete: :cascade
  add_foreign_key "identities", "client_users"
  add_foreign_key "label_templates", "admin_users"
end
