class RecalculateInputPhraseSize < ActiveRecord::Migration[5.2]
  def change

    Translation.update_all("input_length = CHAR_LENGTH(REPLACE(input_phrase, ' ',''))")

  end
end
