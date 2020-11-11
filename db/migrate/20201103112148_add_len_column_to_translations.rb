class AddLenColumnToTranslations < ActiveRecord::Migration[5.2]
  def change
    add_column :translations, :input_length, :integer, default: 0

    # UPDATE translations SET input_length = CHAR_LENGTH(input_phrase);
    Translation.update_all("input_length = CHAR_LENGTH(input_phrase)")

    add_index :translations, :input_length
  end
end
