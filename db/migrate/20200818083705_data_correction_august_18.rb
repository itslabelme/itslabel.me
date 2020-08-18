class DataCorrectionAugust18 < ActiveRecord::Migration[5.2]
  def change

    translations =Translation.all
    temp_hash = {}

    translations.each do |translation|

      hsh[t.id] = {} unless hsh.has_key?(t.id)
      hsh[t.id]["english_phrase"] = t.input_phrase if t.input_language == "ENGLISH"
      hsh[t.id]["arabic_phrase"] = t.input_phrase if t.input_language == "ARABIC"
      hsh[t.id]["french_phrase"] = t.input_phrase if t.input_language == "FRENCH"
      
    end

  end
end
