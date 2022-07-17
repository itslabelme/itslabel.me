# --------------- comment to run migration ---------
class AddDelimitersToTranslation < ActiveRecord::Migration[5.2]
  def change

    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "ARABIC", input_phrase: ",", output_phrase: "،", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "FRENCH", input_phrase: ",", output_phrase: ",", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ARABIC", output_language: "ENGLISH", input_phrase: "،", output_phrase: ",", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ARABIC", output_language: "FRENCH", input_phrase: "،", output_phrase: ",", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "FRENCH", output_language: "ARABIC", input_phrase: ",", output_phrase: "،", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "FRENCH", output_language: "ENGLISH", input_phrase: ",", output_phrase: ",", category: "DELIMITER", status: "APPROVED").save

    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "ARABIC", input_phrase: "and", output_phrase: "و", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "FRENCH", input_phrase: "and", output_phrase: "et", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ARABIC", output_language: "ENGLISH", input_phrase: "و", output_phrase: "and", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ARABIC", output_language: "FRENCH", input_phrase: "و", output_phrase: "et", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "FRENCH", output_language: "ARABIC", input_phrase: "et", output_phrase: "و", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "FRENCH", output_language: "ENGLISH", input_phrase: "et", output_phrase: "and", category: "DELIMITER", status: "APPROVED").save

    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "ARABIC", input_phrase: "or", output_phrase: "أو", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "FRENCH", input_phrase: "or", output_phrase: "ou", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ARABIC", output_language: "ENGLISH", input_phrase: "أو", output_phrase: "or", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ARABIC", output_language: "FRENCH", input_phrase: "أو", output_phrase: "ou", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "FRENCH", output_language: "ARABIC", input_phrase: "ou", output_phrase: "أو", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "FRENCH", output_language: "ENGLISH", input_phrase: "ou", output_phrase: "or", category: "DELIMITER", status: "APPROVED").save




    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "ARABIC", input_phrase: "grams", output_phrase: "جرامات", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "ARABIC", input_phrase: "gram", output_phrase: "غرام", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "ARABIC", input_phrase: "gm", output_phrase: "جم", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "ARABIC", input_phrase: "gms", output_phrase: "جم", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "ARABIC", input_phrase: "g", output_phrase: "غ", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "ARABIC", input_phrase: "mg", output_phrase: "ملغ", category: "DELIMITER", status: "APPROVED").save

    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "FRENCH", input_phrase: "grams", output_phrase: "grammes", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "FRENCH", input_phrase: "gram", output_phrase: "grammes", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "FRENCH", input_phrase: "gm", output_phrase: "gm", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "FRENCH", input_phrase: "gms", output_phrase: "gms", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "FRENCH", input_phrase: "g", output_phrase: "g", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ENGLISH", output_language: "FRENCH", input_phrase: "mg", output_phrase: "mg", category: "DELIMITER", status: "APPROVED").save

    # Translation.find_or_initialize_by(input_language: "ARABIC", output_language: "ENGLISH", input_phrase: "جرامات", output_phrase: "grams", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ARABIC", output_language: "ENGLISH", input_phrase: "غرام", output_phrase: "gram", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ARABIC", output_language: "ENGLISH", input_phrase: "جم", output_phrase: "gm", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ARABIC", output_language: "ENGLISH", input_phrase: "غ", output_phrase: "g", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ARABIC", output_language: "ENGLISH", input_phrase: "ملغ", output_phrase: "mg", category: "DELIMITER", status: "APPROVED").save

    # Translation.find_or_initialize_by(input_language: "ARABIC", output_language: "FRENCH", input_phrase: "جرامات", output_phrase: "grammes", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ARABIC", output_language: "FRENCH", input_phrase: "غرام", output_phrase: "grammes", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ARABIC", output_language: "FRENCH", input_phrase: "جم", output_phrase: "gm", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ARABIC", output_language: "FRENCH", input_phrase: "غ", output_phrase: "g", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "ARABIC", output_language: "FRENCH", input_phrase: "ملغ", output_phrase: "mg", category: "DELIMITER", status: "APPROVED").save

    # Translation.find_or_initialize_by(input_language: "FRENCH", output_language: "ENGLISH", input_phrase: "grammes", output_phrase: "grams", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "FRENCH", output_language: "ENGLISH", input_phrase: "gm", output_phrase: "gm", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "FRENCH", output_language: "ENGLISH", input_phrase: "gms", output_phrase: "gms", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "FRENCH", output_language: "ENGLISH", input_phrase: "g", output_phrase: "g", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "FRENCH", output_language: "ENGLISH", input_phrase: "mg", output_phrase: "mg", category: "DELIMITER", status: "APPROVED").save

    # Translation.find_or_initialize_by(input_language: "FRENCH", output_language: "ARABIC", input_phrase: "grammes", output_phrase: "جرامات", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "FRENCH", output_language: "ARABIC", input_phrase: "gm", output_phrase: "جم", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "FRENCH", output_language: "ARABIC", input_phrase: "gms", output_phrase: "جم", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "FRENCH", output_language: "ARABIC", input_phrase: "g", output_phrase: "غ", category: "DELIMITER", status: "APPROVED").save
    # Translation.find_or_initialize_by(input_language: "FRENCH", output_language: "ARABIC", input_phrase: "mg", output_phrase: "ملغ", category: "DELIMITER", status: "APPROVED").save

  end
end
