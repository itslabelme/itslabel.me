require 'rails_helper'

RSpec.describe Translation, type: :model do

  before :each do

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
    FactoryBot.create(:english_to_french_translation, input_phrase: "or", output_phrase: "ou")

    FactoryBot.create(:english_to_arabic_translation, input_phrase: "and", output_phrase: "و")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "or", output_phrase: "أو")

    FactoryBot.create(:arabic_to_english_translation, input_phrase: "و", output_phrase: "and")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "أو", output_phrase: "or")

    FactoryBot.create(:arabic_to_french_translation, input_phrase: "و", output_phrase: "et")
    FactoryBot.create(:arabic_to_french_translation, input_phrase: "أو", output_phrase: "ou")

    FactoryBot.create(:french_to_english_translation, input_phrase: "et", output_phrase: "and")
    FactoryBot.create(:french_to_english_translation, input_phrase: "ou", output_phrase: "or")

    FactoryBot.create(:french_to_arabic_translation, input_phrase: "et", output_phrase: "و")
    FactoryBot.create(:french_to_arabic_translation, input_phrase: "ou", output_phrase: "أو")

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
    FactoryBot.create(:english_to_french_translation, input_phrase: "Minieral", output_phrase: "Minéral")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Food Acids", output_phrase: "Acides alimentaires")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Lactic Acid", output_phrase: "Acide lactique")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Citric Acid", output_phrase: "Acide citrique")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Spice", output_phrase: "Pimenter")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Whitepepper", output_phrase: "Poivre blanc")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Colours", output_phrase: "Couleurs")

  end

  context "Single Word Translations" do
    it "should translate a single word from english to arabic " do
      expect(Translation.translate_word('Apple')).to eq('تفاحة')
      expect(Translation.translate_word('Mango')).to eq('مانجو')
      expect(Translation.translate_word('Grapes')).to eq('العنب')
      expect(Translation.translate_word('No Word')).to eq(nil)

      expect(Translation.translate_word('Apple', input_language: "ENGLISH", output_language: "ARABIC")).to eq('تفاحة')
      expect(Translation.translate_word('Mango', input_language: "ENGLISH", output_language: "ARABIC")).to eq('مانجو')
      expect(Translation.translate_word('Grapes', input_language: "ENGLISH", output_language: "ARABIC")).to eq('العنب')
      expect(Translation.translate_word('No Word', input_language: "ENGLISH", output_language: "ARABIC")).to eq(nil)
    end

    it "should translate a single word from english to french " do
      expect(Translation.translate_word('Apple', input_language: "ENGLISH", output_language: "FRENCH")).to eq('Pomme')
      expect(Translation.translate_word('Mango', input_language: "ENGLISH", output_language: "FRENCH")).to eq('Mangue')
      expect(Translation.translate_word('Grapes', input_language: "ENGLISH", output_language: "FRENCH")).to eq('Les Raisins')
      expect(Translation.translate_word('No Word', input_language: "ENGLISH", output_language: "FRENCH")).to eq(nil)
    end
    
    it "should translate a single word from arabic to english" do
      expect(Translation.translate_word('تفاحة', input_language: "ARABIC", output_language: "ENGLISH")).to eq('Apple')
      expect(Translation.translate_word('مانجو', input_language: "ARABIC", output_language: "ENGLISH")).to eq('Mango')
      expect(Translation.translate_word('العنب', input_language: "ARABIC", output_language: "ENGLISH")).to eq('Grapes')
      expect(Translation.translate_word('No Word', input_language: "ARABIC", output_language: "ENGLISH")).to eq(nil)
    end

    it "should translate a single word from arabic to french" do
      expect(Translation.translate_word('تفاحة', input_language: "ARABIC", output_language: "FRENCH")).to eq('Pomme')
      expect(Translation.translate_word('مانجو', input_language: "ARABIC", output_language: "FRENCH")).to eq('Mangue')
      expect(Translation.translate_word('العنب', input_language: "ARABIC", output_language: "FRENCH")).to eq('Les Raisins')
      expect(Translation.translate_word('بببب', input_language: "ARABIC", output_language: "FRENCH")).to eq(nil)
    end

    it "should translate a single word from french to english " do
      expect(Translation.translate_word('Pomme', input_language: "FRENCH", output_language: "ENGLISH")).to eq('Apple')
      expect(Translation.translate_word('Mangue', input_language: "FRENCH", output_language: "ENGLISH")).to eq('Mango')
      expect(Translation.translate_word('Les Raisins', input_language: "FRENCH", output_language: "ENGLISH")).to eq('Grapes')
      expect(Translation.translate_word('No Word', input_language: "FRENCH", output_language: "ENGLISH")).to eq(nil)
    end

    it "should translate a single word from french to arabic " do
      expect(Translation.translate_word('Pomme', input_language: "FRENCH", output_language: "ARABIC")).to eq('تفاحة')
      expect(Translation.translate_word('Mangue', input_language: "FRENCH", output_language: "ARABIC")).to eq('مانجو')
      expect(Translation.translate_word('Les Raisins', input_language: "FRENCH", output_language: "ARABIC")).to eq('العنب')
      expect(Translation.translate_word('No Word', input_language: "FRENCH", output_language: "ARABIC")).to eq(nil)
    end
  end

  context "Basic Translations" do

    it "should translate an array of words" do
      # Arabic
      expect(Translation.translate_words(['Apple', 'Mango'])).to include(
        "Apple" => 'تفاحة',
        "Mango" => 'مانجو',
      )
      expect(Translation.translate_words(['Grapes', 'Mango'])).to include(
        "Grapes" => 'العنب',
        "Mango" => 'مانجو',
      )
      expect(Translation.translate_words(['Grapes', 'No Word'])).to include(
        "Grapes" => 'العنب',
        "No Word" => nil,
      )

      # French
      expect(Translation.translate_words(['Apple', 'Mango'], output_language: "FRENCH")).to include(
        "Apple" => 'Pomme',
        "Mango" => 'Mangue',
      )
      expect(Translation.translate_words(['Grapes', 'Mango'], output_language: "FRENCH")).to include(
        "Grapes" => 'Les Raisins',
        "Mango" => 'Mangue',
      )
      expect(Translation.translate_words(['Grapes', 'No Word'], output_language: "FRENCH")).to include(
        "Grapes" => 'Les Raisins',
        "No Word" => nil,
      )
    end

    it "should translate a paragraph" do
      
      # input_paragraph = %{
      #   CORN, VEGETABLE OILS, CHEESE POWDER (MILK), SALT,
      #   BUTTERMILK POWDER (MILK), WHEAT FLOUR, WHEY PROTEIN, 
      #   CONCENTRATE (MILK), TOMATO POWDER, FLAVOUR ENHANCERS, 
      #   (621,631,627),ONION POWDER, WHEY POWDER (MILK), 
      #   GARLIC POWDER, DEXTROSE, SUGAR, NATURAL FLAVOUR, 
      #   MINIERAL, SALT (339), FOOD ACIDS (LACTIC ACID, CITRIC ACID), 
      #   SPICE (WHITEPEPPER), COLOURS (110, 150D).
      # }

      input_paragraph = "CORN, VEGETABLE OILS, CHEESE POWDER (MILK), SALT, BUTTERMILK POWDER (MILK), WHEAT FLOUR, WHEY PROTEIN, CONCENTRATE (MILK), TOMATO POWDER, FLAVOUR ENHANCERS, (621,631,627),ONION POWDER, WHEY POWDER (MILK), GARLIC POWDER, DEXTROSE, SUGAR, NATURAL FLAVOUR, MINIERAL, SALT (339), FOOD ACIDS (LACTIC ACID, CITRIC ACID), SPICE (WHITEPEPPER), COLOURS (110, 150D)."

      expect(Translation.translate_paragraph(input_paragraph, return_in_hash: true, output_language: "FRENCH")).to include(
        "CORN" => 'blé',
        "COLOURS" => 'Couleurs',
      )
      # output_paragraph = %{
      #   blé, Les Huiles végétales, Poudre de fromage (Lait), Sel,
      #   BUTTERLait POWDER (Lait), Farine de blé, Protéine de whey,
      #   Concentrer (Lait), Poudre de tomate, Exhausteurs de goût,
      #   (621,631,627),Poudre d'oignon, La poudre de lactosérum (Lait),
      #   Poudre d'ail, Dextrose, Sucre, Saveur naturelle,
      #   Minéral, Sel (339), Acides alimentaires (Acide lactique, Acide citrique),
      #   Pimenter (Poivre blanc), Couleurs (110, 150D).
      # }

      output_paragraph = "blé, Les Huiles végétales, Poudre de fromage (Lait), Sel, BUTTERLait POWDER (Lait), Farine de blé, Protéine de whey, Concentrer (Lait), Poudre de tomate, Exhausteurs de goût, (621,631,627),Poudre d'oignon, La poudre de lactosérum (Lait), Poudre d'ail, Dextrose, Sucre, Saveur naturelle, Minéral, Sel (339), Acides alimentaires (Acide lactique, Acide citrique), Pimenter (Poivre blanc), Couleurs (110, 150D)."
      expect(Translation.translate_paragraph(input_paragraph, output_language: "FRENCH")).to eq(output_paragraph)
    end

    it "should translate anything" do
      
      # Arabic

      expect(Translation.translate('Apple')).to eq('تفاحة')
      expect(Translation.translate('Mango')).to eq('مانجو')
      expect(Translation.translate('Grapes')).to eq('العنب')
      expect(Translation.translate('No Word')).to eq("No Word")

      expect(Translation.translate(['Apple', 'Mango'])).to include(
        "Apple" => 'تفاحة',
        "Mango" => 'مانجو',
      )
      expect(Translation.translate(['Grapes', 'Mango'])).to include(
        "Grapes" => 'العنب',
        "Mango" => 'مانجو',
      )
      expect(Translation.translate(['Grapes', 'No Word'])).to include(
        "Grapes" => 'العنب',
        "No Word" => nil,
      )

      # French

      expect(Translation.translate('Apple', output_language: "FRENCH")).to eq('Pomme')
      expect(Translation.translate('Mango', output_language: "FRENCH")).to eq('Mangue')
      expect(Translation.translate('Grapes', output_language: "FRENCH")).to eq('Les Raisins')
      expect(Translation.translate('No Word', output_language: "FRENCH")).to eq("No Word")

      expect(Translation.translate(['Apple', 'Mango'], output_language: "FRENCH")).to include(
        "Apple" => 'Pomme',
        "Mango" => 'Mangue',
      )
      expect(Translation.translate(['Grapes', 'Mango'], output_language: "FRENCH")).to include(
        "Grapes" => 'Les Raisins',
        "Mango" => 'Mangue',
      )
      expect(Translation.translate(['Grapes', 'No Word'], output_language: "FRENCH")).to include(
        "Grapes" => 'Les Raisins',
        "No Word" => nil,
      )
    end

  end

  context "HTML Translations" do

    it "should translate html input" do
      input_html =  %{ <html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">CORN, VEGETABLE OILS, CHEESE POWDER (MILK), SALT,BUTTERMILK POWDER (MILK), WHEAT FLOUR, WHEY PROTEIN, CONCENTRATE (MILK), TOMATO POWDER, FLAVOUR ENHANCERS, (621,631,627),ONION POWDER, WHEY POWDER (MILK), GARLIC POWDER, DEXTROSE, SUGAR, NATURAL FLAVOUR, MINIERAL, SALT (339), FOOD ACIDS (LACTIC ACID, CITRIC ACID), SPICE (WHITEPEPPER), COLOURS (110, 150D).</td></tr></tbody></table></body></html>}
      output_html = %{ <html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">blé, Les Huiles végétales, Poudre de fromage (Lait), Sel,BUTTERLait POWDER (Lait), Farine de blé, Protéine de whey, Concentrer (Lait), Poudre de tomate, Exhausteurs de goût, (621,631,627),Poudre d'oignon, La poudre de lactosérum (Lait), Poudre d'ail, Dextrose, Sucre, Saveur naturelle, Minéral, Sel (339), Acides alimentaires (Acide lactique, Acide citrique), Pimenter (Poivre blanc), Couleurs (110, 150D).</td></tr></tbody></table></body></html>}
      translated_html = Translation.translate_html(input_html, output_language: "FRENCH")
      expect(translated_html).not_to be_empty
      expect(translated_html).to include('blé')
      expect(translated_html).to include('Couleurs')
      expect(translated_html).to include('Poudre de fromage')
      expect(translated_html).to include('Lait')
      expect(translated_html).to include('(Poivre blanc)')
    end

  end

  context "Advanced Translations" do

    it "should translate anything" do

      # English to Arabic
      expect(Translation.translate('Apple, Mango and Grapes.', return_in_hash: true)).to include(
        "Apple" => 'تفاحة',
        "," => '،',
        "Mango" => 'مانجو',
        "and" => 'و',
        "Grapes" => 'العنب',
        "." => '.',
      )

      # English to French
      expect(Translation.translate('Apple, Mango and Grapes.', input_language: "ENGLISH", output_language: "FRENCH", return_in_hash: true)).to include(
        "Apple" => 'Pomme',
        "," => ',',
        "Mango" => 'Mangue',
        "and" => 'et',
        "Grapes" => 'Les Raisins',
        "." => '.',
      )

      FactoryBot.create(:arabic_to_english_translation, input_phrase: "تفاحة", output_phrase: "Apple")
      FactoryBot.create(:arabic_to_english_translation, input_phrase: "مانج", output_phrase: "Mango")
      FactoryBot.create(:arabic_to_english_translation, input_phrase: "عنب", output_phrase: "Grapes")

      # Arabic to English
      expect(Translation.translate('تفاحة ، مانجو وعنب.', input_language: "ARABIC", output_language: "ENGLISH", return_in_hash: true)).to include(
        "تفاحة" => 'Apple',
        "،" => ',',
        "مانج" => 'Mango',
        "و" => 'and',
        "عنب" => 'Grapes',
        "." => '.',
      )

      # # Arabic to French
      # expect(Translation.translate('التفاح والمانجو والعنب.', input_language: "ARABIC", output_language: "FRENCH", return_in_hash: true)).to include(
      #   "تفاحة" => 'Pomme',
      #   "،" => ',',
      #   "مانجو" => 'Mangue',
      #   "و" => 'et',
      #   "العنب" => 'Les Raisins',
      #   "." => '.',
      # )

    end

  end

end

# Input text for reference
# التفاح والمانجو والعنب.
# Apple. Mango. 
# .Apple
# Apple 12.500 grams, 100 gms Grapes and Apple.

# 12.500 grams Apple, 
# 12.5 gms Apple
# 1 gm Apple

# 12.500grams Apple, 
# 12.5gms Apple
# 1gm Apple