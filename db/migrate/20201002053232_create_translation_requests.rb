class CreateTranslationRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :translation_requests do |t|

      t.belongs_to :requested_by, class_name: "ClientUser"

      t.text :input_phrase, null: false
      t.string :input_language, limit: 16, null: false
      t.text :output_phrase, null: true
      t.string :output_language, limit: 16, null: false
      t.string :doc_type, limit: 256, null: true

      t.string :status, default: "ACTIVE", limit: 16, null: false

      t.timestamps null: false
    end
  end
end