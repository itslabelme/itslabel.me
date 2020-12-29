RSpec.shared_context 'dataset' do 
  before do

    # Commas, dots and other literals
    FactoryBot.create(:english_to_arabic_translation, input_phrase: ".", output_phrase: ".")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: ",", output_phrase: "،")

    FactoryBot.create(:english_to_french_translation, input_phrase: ".", output_phrase: ".")
    FactoryBot.create(:english_to_french_translation, input_phrase: ",", output_phrase: ",")

    FactoryBot.create(:arabic_to_english_translation, input_phrase: ".", output_phrase: ".")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "،", output_phrase: ",")

    FactoryBot.create(:arabic_to_french_translation, input_phrase: ".", output_phrase: ".")
    FactoryBot.create(:arabic_to_french_translation, input_phrase: "،", output_phrase: ",")

    FactoryBot.create(:french_to_english_translation, input_phrase: ".", output_phrase: ".")
    FactoryBot.create(:french_to_english_translation, input_phrase: ",", output_phrase: ",")

    FactoryBot.create(:french_to_arabic_translation, input_phrase: ".", output_phrase: ".")
    FactoryBot.create(:french_to_arabic_translation, input_phrase: ",", output_phrase: "،")

    # & and or
    FactoryBot.create(:english_to_french_translation, input_phrase: "and", output_phrase: "et")
    FactoryBot.create(:english_to_french_translation, input_phrase: "&", output_phrase: "et")
    FactoryBot.create(:english_to_french_translation, input_phrase: "or", output_phrase: "ou")

    FactoryBot.create(:english_to_arabic_translation, input_phrase: "and", output_phrase: "و")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "&", output_phrase: "و")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "or", output_phrase: "أو")

    FactoryBot.create(:arabic_to_english_translation, input_phrase: "و", output_phrase: "and")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "أو", output_phrase: "or")

    FactoryBot.create(:arabic_to_french_translation, input_phrase: "و", output_phrase: "et")
    FactoryBot.create(:arabic_to_french_translation, input_phrase: "أو", output_phrase: "ou")

    FactoryBot.create(:french_to_english_translation, input_phrase: "et", output_phrase: "and")
    FactoryBot.create(:french_to_english_translation, input_phrase: "ou", output_phrase: "or")

    FactoryBot.create(:french_to_arabic_translation, input_phrase: "et", output_phrase: "و")
    FactoryBot.create(:french_to_arabic_translation, input_phrase: "ou", output_phrase: "أو")

    # of
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "of", output_phrase: "من")
    FactoryBot.create(:english_to_french_translation, input_phrase: "of", output_phrase: "de")
    FactoryBot.create(:arabic_to_french_translation, input_phrase: "من", output_phrase: "de")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "من", output_phrase: "of")
    FactoryBot.create(:french_to_english_translation, input_phrase: "de", output_phrase: "من")
    FactoryBot.create(:french_to_arabic_translation, input_phrase: "de", output_phrase: "من")


    # Delimiter Translations
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "grams", output_phrase: "جرامات")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "gram", output_phrase: "غرام")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "gm", output_phrase: "جم")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "gms", output_phrase: "جم")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "g", output_phrase: "غ")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "mg", output_phrase: "ملغ")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "%", output_phrase: "%")

    FactoryBot.create(:english_to_french_translation, input_phrase: "grams", output_phrase: "grammes")
    FactoryBot.create(:english_to_french_translation, input_phrase: "gram", output_phrase: "grammes")
    FactoryBot.create(:english_to_french_translation, input_phrase: "gm", output_phrase: "gm")
    FactoryBot.create(:english_to_french_translation, input_phrase: "gms", output_phrase: "gms")
    FactoryBot.create(:english_to_french_translation, input_phrase: "g", output_phrase: "g")
    FactoryBot.create(:english_to_french_translation, input_phrase: "mg", output_phrase: "mg")
    FactoryBot.create(:english_to_french_translation, input_phrase: "%", output_phrase: "%")

    FactoryBot.create(:arabic_to_english_translation, input_phrase: "جرامات", output_phrase: "grams")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "غرام", output_phrase: "gram")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "جم", output_phrase: "gm")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "غ", output_phrase: "g")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "ملغ", output_phrase: "mg")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "%", output_phrase: "%")

    FactoryBot.create(:arabic_to_french_translation, input_phrase: "جرامات", output_phrase: "grammes")
    FactoryBot.create(:arabic_to_french_translation, input_phrase: "غرام", output_phrase: "grammes")
    FactoryBot.create(:arabic_to_french_translation, input_phrase: "جم", output_phrase: "gm")
    FactoryBot.create(:arabic_to_french_translation, input_phrase: "غ", output_phrase: "g")
    FactoryBot.create(:arabic_to_french_translation, input_phrase: "ملغ", output_phrase: "mg")
    FactoryBot.create(:arabic_to_french_translation, input_phrase: "%", output_phrase: "%")

    FactoryBot.create(:french_to_english_translation, input_phrase: "grammes", output_phrase: "grams")
    FactoryBot.create(:french_to_english_translation, input_phrase: "gm", output_phrase: "gm")
    FactoryBot.create(:french_to_english_translation, input_phrase: "gms", output_phrase: "gms")
    FactoryBot.create(:french_to_english_translation, input_phrase: "g", output_phrase: "g")
    FactoryBot.create(:french_to_english_translation, input_phrase: "mg", output_phrase: "mg")
    FactoryBot.create(:french_to_english_translation, input_phrase: "%", output_phrase: "%")

    FactoryBot.create(:french_to_arabic_translation, input_phrase: "grammes", output_phrase: "جرامات")
    FactoryBot.create(:french_to_arabic_translation, input_phrase: "gm", output_phrase: "جم")
    FactoryBot.create(:french_to_arabic_translation, input_phrase: "gms", output_phrase: "جم")
    FactoryBot.create(:french_to_arabic_translation, input_phrase: "g", output_phrase: "غ")
    FactoryBot.create(:french_to_arabic_translation, input_phrase: "mg", output_phrase: "ملغ")
    FactoryBot.create(:french_to_arabic_translation, input_phrase: "%", output_phrase: "%")


    # Apple, Mango and Grapes
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "Apple", output_phrase: "تفاحة")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "Mango", output_phrase: "مانجو")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "Grapes", output_phrase: "العنب")

    FactoryBot.create(:english_to_french_translation, input_phrase: "Apple", output_phrase: "Pomme")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Mango", output_phrase: "Mangue")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Grapes", output_phrase: "Les Raisins")

    FactoryBot.create(:arabic_to_english_translation, input_phrase: "تفاحة", output_phrase: "Apple")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "مانجو", output_phrase: "Mango")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "العنب", output_phrase: "Grapes")

    FactoryBot.create(:arabic_to_french_translation, input_phrase: "تفاحة", output_phrase: "Pomme")
    FactoryBot.create(:arabic_to_french_translation, input_phrase: "مانجو", output_phrase: "Mangue")
    FactoryBot.create(:arabic_to_french_translation, input_phrase: "العنب", output_phrase: "Les Raisins")

    FactoryBot.create(:french_to_english_translation, input_phrase: "Pomme", output_phrase: "Apple")
    FactoryBot.create(:french_to_english_translation, input_phrase: "Mangue", output_phrase: "Mango")
    FactoryBot.create(:french_to_english_translation, input_phrase: "Les Raisins", output_phrase: "Grapes")

    FactoryBot.create(:french_to_arabic_translation, input_phrase: "Pomme", output_phrase: "تفاحة")
    FactoryBot.create(:french_to_arabic_translation, input_phrase: "Mangue", output_phrase: "مانجو")
    FactoryBot.create(:french_to_arabic_translation, input_phrase: "Les Raisins", output_phrase: "العنب")


    # Mik, Butter and Ghee
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "Milk", output_phrase: "حليب")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "Butter", output_phrase: "زبدة")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "Ghee", output_phrase: "السمن")

    FactoryBot.create(:arabic_to_english_translation, input_phrase: "حليب", output_phrase: "Milk")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "زبدة", output_phrase: "Butter")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "السمن", output_phrase: "Ghee")

    # Sodium Chloride
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "Sodium Chloride", output_phrase: "كلوريد الصوديوم")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Sodium Chloride", output_phrase: "Chlorure de sodium")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "كلوريد الصوديوم", output_phrase: "Sodium Chloride")
    FactoryBot.create(:arabic_to_french_translation, input_phrase: "كلوريد الصوديوم", output_phrase: "Chlorure de sodium")
    FactoryBot.create(:french_to_english_translation, input_phrase: "Chlorure de sodium", output_phrase: "Sodium Chloride")
    FactoryBot.create(:french_to_arabic_translation, input_phrase: "Chlorure de sodium", output_phrase: "كلوريد الصوديوم")
    
    # Generic Data to test a generic label
    FactoryBot.create(:english_to_french_translation, input_phrase: "Corn", output_phrase: "blé")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Vegetable Oils", output_phrase: "Les Huiles végétales")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Cheese Powder", output_phrase: "Poudre de fromage")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Milk", output_phrase: "Lait")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Salt", output_phrase: "Sel")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Buttermilk Powder", output_phrase: "Poudre de papillon")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Wheat Flour", output_phrase: "Farine de blé")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Whey Protein", output_phrase: "Protéine de whey")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Concentrate", output_phrase: "Concentrer")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Tomato Powder", output_phrase: "Poudre de tomate")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Flavour Enhancers", output_phrase: "Exhausteurs de goût")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Onion Powder", output_phrase: "Poudre d'oignon")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Whey Powder", output_phrase: "La poudre de lactosérum")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Garlic Powder", output_phrase: "Poudre d'ail")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Dextrose", output_phrase: "Dextrose")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Sugar", output_phrase: "Sucre")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Natural Flavour", output_phrase: "Saveur naturelle")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Mineral", output_phrase: "Minéral")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Food Acids", output_phrase: "Acides alimentaires")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Lactic Acid", output_phrase: "Acide lactique")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Citric Acid", output_phrase: "Acide citrique")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Spice", output_phrase: "Pimenter")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Whitepepper", output_phrase: "Poivre blanc")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Colours", output_phrase: "Couleurs")
  end
end