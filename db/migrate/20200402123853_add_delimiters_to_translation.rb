class AddDelimitersToTranslation < ActiveRecord::Migration[5.2]
  def change

    Translation.find_or_initialize_by(english_phrase: ",", arabic_phrase: "،", french_phrase: ",", category: "DELIMITER", status: "APPROVED").save
    
    
    Translation.find_or_initialize_by(english_phrase: "and", arabic_phrase: "و", french_phrase: "et", category: "DELIMITER", status: "APPROVED").save
    

    Translation.find_or_initialize_by( english_phrase: "or", arabic_phrase: "أو", french_phrase: "ou", category: "DELIMITER", status: "APPROVED").save
    



    Translation.find_or_initialize_by( english_phrase: "grams", arabic_phrase: "جرامات",french_phrase: "grammes", category: "DELIMITER", status: "APPROVED").save
    Translation.find_or_initialize_by( english_phrase: "gram", arabic_phrase: "غرام",french_phrase: "grammes", category: "DELIMITER", status: "APPROVED").save
    Translation.find_or_initialize_by( english_phrase: "gm", arabic_phrase: "جم", french_phrase: "gm", category: "DELIMITER", status: "APPROVED").save
    Translation.find_or_initialize_by( english_phrase: "gms", arabic_phrase: "جم", french_phrase: "gms", category: "DELIMITER", status: "APPROVED").save
    Translation.find_or_initialize_by( english_phrase: "g", arabic_phrase: "غ",french_phrase: "g", category: "DELIMITER", status: "APPROVED").save
    Translation.find_or_initialize_by( english_phrase: "mg", arabic_phrase: "ملغ",french_phrase: "mg", category: "DELIMITER", status: "APPROVED").save

    

  end
end
