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

ActiveRecord::Schema.define(version: 2020_01_20_060637) do

  create_table "admin_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name"
    t.bigint "phone"
    t.string "organisation"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "client_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name"
    t.bigint "phone"
    t.string "organisation"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_client_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_client_users_on_reset_password_token", unique: true
  end

  create_table "documents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", limit: 256, null: false
    t.string "type", limit: 128
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "table_tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "document_id"
    t.string "source_langage", limit: 256, null: false
    t.string "output_language", limit: 256
    t.string "input_phrase", limit: 256
    t.string "output_phrase", limit: 256
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_table_tags_on_document_id"
  end

  create_table "template_tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "document_id"
    t.string "source_langage", limit: 256, null: false
    t.string "output_language", limit: 256
    t.string "input_phrase", limit: 256
    t.string "output_phrase", limit: 256
    t.string "phrase_group", limit: 256
    t.string "ingradiant_weight", limit: 256
    t.string "ingradiant_percentage", limit: 256
    t.string "footer_text", limit: 1024
    t.string "tags", limit: 1024
    t.index ["document_id"], name: "index_template_tags_on_document_id"
  end

  create_table "translations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "input_phrase", limit: 256, null: false
    t.string "input_description", limit: 1024
    t.string "input_language", limit: 16, null: false
    t.string "output_phrase", limit: 256, null: false
    t.string "output_description", limit: 1024
    t.string "output_language", limit: 16, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "documents", "client_users", column: "user_id", on_delete: :cascade
  add_foreign_key "table_tags", "documents", on_delete: :cascade
  add_foreign_key "template_tags", "documents", on_delete: :cascade
end
