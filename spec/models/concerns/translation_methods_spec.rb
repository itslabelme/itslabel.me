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

    # Delimiter Translations
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "grams", output_phrase: "جرامات")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "gram", output_phrase: "غرام")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "gm", output_phrase: "جم")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "gms", output_phrase: "جم")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "g", output_phrase: "غ")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "mg", output_phrase: "ملغ")

    FactoryBot.create(:english_to_french_translation, input_phrase: "grams", output_phrase: "grammes")
    FactoryBot.create(:english_to_french_translation, input_phrase: "gram", output_phrase: "grammes")
    FactoryBot.create(:english_to_french_translation, input_phrase: "gm", output_phrase: "gm")
    FactoryBot.create(:english_to_french_translation, input_phrase: "gms", output_phrase: "gms")
    FactoryBot.create(:english_to_french_translation, input_phrase: "g", output_phrase: "g")
    FactoryBot.create(:english_to_french_translation, input_phrase: "mg", output_phrase: "mg")

    FactoryBot.create(:arabic_to_english_translation, input_phrase: "جرامات", output_phrase: "grams")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "غرام", output_phrase: "gram")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "جم", output_phrase: "gm")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "غ", output_phrase: "g")
    FactoryBot.create(:arabic_to_english_translation, input_phrase: "ملغ", output_phrase: "mg")

    FactoryBot.create(:arabic_to_french_translation, input_phrase: "جرامات", output_phrase: "grammes")
    FactoryBot.create(:arabic_to_french_translation, input_phrase: "غرام", output_phrase: "grammes")
    FactoryBot.create(:arabic_to_french_translation, input_phrase: "جم", output_phrase: "gm")
    FactoryBot.create(:arabic_to_french_translation, input_phrase: "غ", output_phrase: "g")
    FactoryBot.create(:arabic_to_french_translation, input_phrase: "ملغ", output_phrase: "mg")

    FactoryBot.create(:french_to_english_translation, input_phrase: "grammes", output_phrase: "grams")
    FactoryBot.create(:french_to_english_translation, input_phrase: "gm", output_phrase: "gm")
    FactoryBot.create(:french_to_english_translation, input_phrase: "gms", output_phrase: "gms")
    FactoryBot.create(:french_to_english_translation, input_phrase: "g", output_phrase: "g")
    FactoryBot.create(:french_to_english_translation, input_phrase: "mg", output_phrase: "mg")

    FactoryBot.create(:french_to_arabic_translation, input_phrase: "grammes", output_phrase: "جرامات")
    FactoryBot.create(:french_to_arabic_translation, input_phrase: "gm", output_phrase: "جم")
    FactoryBot.create(:french_to_arabic_translation, input_phrase: "gms", output_phrase: "جم")
    FactoryBot.create(:french_to_arabic_translation, input_phrase: "g", output_phrase: "غ")
    FactoryBot.create(:french_to_arabic_translation, input_phrase: "mg", output_phrase: "ملغ")


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
      real_output = Translation.translate_paragraph(input_paragraph, output_language: "FRENCH")
      expect(real_output).to eq(output_paragraph)
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
      input_html =  %{ <div><span>10g</span></div>}
      output_html =  %{ <div><span>10غ</span></div>}
      translated_html = Translation.translate_html(input_html, input_language: "ENGLISH", output_language: "ARABIC").to_html
      expect(translated_html).not_to be_empty
      expect(translated_html).to include('10غ')

      input_html =  %{ <div><span>10gm</span></div>}
      output_html =  %{ <div><span>10جم</span></div>}
      translated_html = Translation.translate_html(input_html, input_language: "ENGLISH", output_language: "ARABIC").to_html
      expect(translated_html).not_to be_empty
      expect(translated_html).to include('10جم')

      input_html =  %{ <div><span>10grams</span></div>}
      output_html =  %{ <div><span>10جرامات</span></div>}
      translated_html = Translation.translate_html(input_html, input_language: "ENGLISH", output_language: "ARABIC").to_html
      expect(translated_html).not_to be_empty
      expect(translated_html).to include('10جرامات')

      input_html =  %{ <div><span>1gram</span></div>}
      output_html =  %{ <div><span>1غرام</span></div>}
      translated_html = Translation.translate_html(input_html, input_language: "ENGLISH", output_language: "ARABIC").to_html
      expect(translated_html).not_to be_empty
      expect(translated_html).to include('1غرام')
    end

    xit "should translate html input" do
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

  context "Translation with Basic Delimitters" do

    it "should translate commas and 'and'" do

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
      expect(Translation.translate('تفاحة ، مانج و عنب.', input_language: "ARABIC", output_language: "ENGLISH", return_in_hash: true)).to include(
        "تفاحة" => 'Apple',
        "،" => ',',
        "مانج" => 'Mango',
        "و" => 'and',
        "عنب" => 'Grapes',
        "." => '.',
      )

      FactoryBot.create(:arabic_to_french_translation, input_phrase: "تفاحة", output_phrase: "Pomme")
      FactoryBot.create(:arabic_to_french_translation, input_phrase: "مانج", output_phrase: "Mangue")
      FactoryBot.create(:arabic_to_french_translation, input_phrase: "عنب", output_phrase: "Les Raisins")

      # # Arabic to French
      expect(Translation.translate('تفاحة ، مانج و عنب.', input_language: "ARABIC", output_language: "FRENCH", return_in_hash: true)).to include(
        "تفاحة" => 'Pomme',
        "،" => ',',
        "مانج" => 'Mangue',
        "و" => 'et',
        "عنب" => 'Les Raisins',
        "." => '.',
      )
    end

    it "should translate ingredient weights in multiple formats - Part 2" do

      # English to Arabic
      expect(Translation.translate('12.500gm Apple, 12.5gm Mango and 1gm Grapes.', return_in_hash: true)).to include(
        "12.500gm" => "جم 12.500",
        "Apple" => 'تفاحة',
        "12.5gm" => "جم 12.5",
        "Mango" => 'مانجو',
        "1gm" => "جم 1",
        "," => '،',
        "and" => 'و',
        "Grapes" => 'العنب',
        "." => '.',
      )

      # # English to French
      # expect(Translation.translate('Apple, Mango and Grapes.', input_language: "ENGLISH", output_language: "FRENCH", return_in_hash: true)).to include(
      #   "Apple" => 'Pomme',
      #   "," => ',',
      #   "Mango" => 'Mangue',
      #   "and" => 'et',
      #   "Grapes" => 'Les Raisins',
      #   "." => '.',
      # )

      # FactoryBot.create(:arabic_to_english_translation, input_phrase: "تفاحة", output_phrase: "Apple")
      # FactoryBot.create(:arabic_to_english_translation, input_phrase: "مانج", output_phrase: "Mango")
      # FactoryBot.create(:arabic_to_english_translation, input_phrase: "عنب", output_phrase: "Grapes")

      # # Arabic to English
      # expect(Translation.translate('تفاحة ، مانج و عنب.', input_language: "ARABIC", output_language: "ENGLISH", return_in_hash: true)).to include(
      #   "تفاحة" => 'Apple',
      #   "،" => ',',
      #   "مانج" => 'Mango',
      #   "و" => 'and',
      #   "عنب" => 'Grapes',
      #   "." => '.',
      # )

      # FactoryBot.create(:arabic_to_french_translation, input_phrase: "تفاحة", output_phrase: "Pomme")
      # FactoryBot.create(:arabic_to_french_translation, input_phrase: "مانج", output_phrase: "Mangue")
      # FactoryBot.create(:arabic_to_french_translation, input_phrase: "عنب", output_phrase: "Les Raisins")

      # # # Arabic to French
      # expect(Translation.translate('تفاحة ، مانج و عنب.', input_language: "ARABIC", output_language: "FRENCH", return_in_hash: true)).to include(
      #   "تفاحة" => 'Pomme',
      #   "،" => ',',
      #   "مانج" => 'Mangue',
      #   "و" => 'et',
      #   "عنب" => 'Les Raisins',
      #   "." => '.',
      # )
    end
  end

  context "Delimiter Translation" do

    it "should translate numeric delimitter combinations" do
      expect(Translation.translate_delimiter('12.500')).to eq("12.500")
      expect(Translation.translate_delimiter('12.50')).to eq("12.50")
      expect(Translation.translate_delimiter('12.5')).to eq("12.5")
      expect(Translation.translate_delimiter('12')).to eq("12")
      
      options = {input_language: "ENGLISH", output_language: "ARABIC"}
      expect(Translation.translate_delimiter('12.500', options)).to eq("12.500")
      expect(Translation.translate_delimiter('12.50', options)).to eq("12.50")
      expect(Translation.translate_delimiter('12.5', options)).to eq("12.5")
      expect(Translation.translate_delimiter('12', options)).to eq("12")
    end

    it "should translate numeric delimitter combinations with %" do
      expect(Translation.translate_delimiter('12.500%')).to eq("12.500%")
      expect(Translation.translate_delimiter('12.50%')).to eq("12.50%")
      expect(Translation.translate_delimiter('12.5%')).to eq("12.5%")
      expect(Translation.translate_delimiter('12%')).to eq("12%")
      
      expect(Translation.translate_delimiter('12.500 %')).to eq("12.500 %")
      expect(Translation.translate_delimiter('12.50 %')).to eq("12.50 %")
      expect(Translation.translate_delimiter('12.5 %')).to eq("12.5 %")
      expect(Translation.translate_delimiter('12 %')).to eq("12 %")
      
      options = {input_language: "ENGLISH", output_language: "ARABIC"}
      expect(Translation.translate_delimiter('12.500%', options)).to eq("%12.500")
      expect(Translation.translate_delimiter('12.50%', options)).to eq("%12.50")
      expect(Translation.translate_delimiter('12.5%', options)).to eq("%12.5")
      expect(Translation.translate_delimiter('12%', options)).to eq("%12")
      
      expect(Translation.translate_delimiter('12.500 %', options)).to eq("%12.500")
      expect(Translation.translate_delimiter('12.50 %', options)).to eq("%12.50")
      expect(Translation.translate_delimiter('12.5 %', options)).to eq("%12.5")
      expect(Translation.translate_delimiter('12 %', options)).to eq("%12")
    end

    it "should translate all possible delimitter combinations" do

      options = {input_language: "ENGLISH", output_language: "FRENCH"}

      expect(Translation.translate_delimiter('12.500 grams', options)).to eq("12.500 grammes")
      expect(Translation.translate_delimiter('12.50 grams', options)).to eq("12.50 grammes")
      expect(Translation.translate_delimiter('12.5 grams', options)).to eq("12.5 grammes")
      expect(Translation.translate_delimiter('12 grams', options)).to eq("12 grammes")

      expect(Translation.translate_delimiter('12.500 gram', options)).to eq("12.500 grammes")
      expect(Translation.translate_delimiter('12.50 gram', options)).to eq("12.50 grammes")
      expect(Translation.translate_delimiter('12.5 gram', options)).to eq("12.5 grammes")
      expect(Translation.translate_delimiter('12 gram', options)).to eq("12 grammes")

      expect(Translation.translate_delimiter('12.500 gms', options)).to eq("12.500 gms")
      expect(Translation.translate_delimiter('12.50 gms', options)).to eq("12.50 gms")
      expect(Translation.translate_delimiter('12.5 gms', options)).to eq("12.5 gms")
      expect(Translation.translate_delimiter('12 gms', options)).to eq("12 gms")

      expect(Translation.translate_delimiter('12.500 mg', options)).to eq("12.500 mg")
      expect(Translation.translate_delimiter('12.50 mg', options)).to eq("12.50 mg")
      expect(Translation.translate_delimiter('12.5 mg', options)).to eq("12.5 mg")
      expect(Translation.translate_delimiter('12 mg', options)).to eq("12 mg")

      expect(Translation.translate_delimiter('12.500 gm', options)).to eq("12.500 gm")
      expect(Translation.translate_delimiter('12.50 gm', options)).to eq("12.50 gm")
      expect(Translation.translate_delimiter('12.5 gm', options)).to eq("12.5 gm")
      expect(Translation.translate_delimiter('12 gm', options)).to eq("12 gm")

      expect(Translation.translate_delimiter('12.500 g', options)).to eq("12.500 g")
      expect(Translation.translate_delimiter('12.50 g', options)).to eq("12.50 g")
      expect(Translation.translate_delimiter('12.5 g', options)).to eq("12.5 g")
      expect(Translation.translate_delimiter('12 g', options)).to eq("12 g")

      

      options = {input_language: "ENGLISH", output_language: "FRENCH"}

      expect(Translation.translate_delimiter('12.500grams', options)).to eq("12.500 grammes")
      expect(Translation.translate_delimiter('12.50grams', options)).to eq("12.50 grammes")
      expect(Translation.translate_delimiter('12.5grams', options)).to eq("12.5 grammes")
      expect(Translation.translate_delimiter('12grams', options)).to eq("12 grammes")

      expect(Translation.translate_delimiter('12.500gram', options)).to eq("12.500 grammes")
      expect(Translation.translate_delimiter('12.50gram', options)).to eq("12.50 grammes")
      expect(Translation.translate_delimiter('12.5gram', options)).to eq("12.5 grammes")
      expect(Translation.translate_delimiter('12gram', options)).to eq("12 grammes")

      expect(Translation.translate_delimiter('12.500gms', options)).to eq("12.500 gms")
      expect(Translation.translate_delimiter('12.50gms', options)).to eq("12.50 gms")
      expect(Translation.translate_delimiter('12.5gms', options)).to eq("12.5 gms")
      expect(Translation.translate_delimiter('12gms', options)).to eq("12 gms")

      expect(Translation.translate_delimiter('12.500gm', options)).to eq("12.500 gm")
      expect(Translation.translate_delimiter('12.50gm', options)).to eq("12.50 gm")
      expect(Translation.translate_delimiter('12.5gm', options)).to eq("12.5 gm")
      expect(Translation.translate_delimiter('12gm', options)).to eq("12 gm")

      expect(Translation.translate_delimiter('12.500mg', options)).to eq("12.500 mg")
      expect(Translation.translate_delimiter('12.50mg', options)).to eq("12.50 mg")
      expect(Translation.translate_delimiter('12.5mg', options)).to eq("12.5 mg")
      expect(Translation.translate_delimiter('12mg', options)).to eq("12 mg")

      expect(Translation.translate_delimiter('12.500g', options)).to eq("12.500 g")
      expect(Translation.translate_delimiter('12.50g', options)).to eq("12.50 g")
      expect(Translation.translate_delimiter('12.5g', options)).to eq("12.5 g")
      expect(Translation.translate_delimiter('12g', options)).to eq("12 g")


      options = {input_language: "ENGLISH", output_language: "ARABIC"}

      expect(Translation.translate_delimiter('12.500grams', options)).to eq("جرامات 12.500")
      expect(Translation.translate_delimiter('12.50grams', options)).to eq("جرامات 12.50")
      expect(Translation.translate_delimiter('12.5grams', options)).to eq("جرامات 12.5")
      expect(Translation.translate_delimiter('12grams', options)).to eq("جرامات 12")

      expect(Translation.translate_delimiter('12.500gram', options)).to eq("غرام 12.500")
      expect(Translation.translate_delimiter('12.50gram', options)).to eq("غرام 12.50")
      expect(Translation.translate_delimiter('12.5gram', options)).to eq("غرام 12.5")
      expect(Translation.translate_delimiter('12gram', options)).to eq("غرام 12")

      expect(Translation.translate_delimiter('12.500gms', options)).to eq("جم 12.500")
      expect(Translation.translate_delimiter('12.50gms', options)).to eq("جم 12.50")
      expect(Translation.translate_delimiter('12.5gms', options)).to eq("جم 12.5")
      expect(Translation.translate_delimiter('12gms', options)).to eq("جم 12")

      expect(Translation.translate_delimiter('12.500gm', options)).to eq("جم 12.500")
      expect(Translation.translate_delimiter('12.50gm', options)).to eq("جم 12.50")
      expect(Translation.translate_delimiter('12.5gm', options)).to eq("جم 12.5")
      expect(Translation.translate_delimiter('12gm', options)).to eq("جم 12")

      expect(Translation.translate_delimiter('12.500mg', options)).to eq("ملغ 12.500")
      expect(Translation.translate_delimiter('12.50mg', options)).to eq("ملغ 12.50")
      expect(Translation.translate_delimiter('12.5mg', options)).to eq("ملغ 12.5")
      expect(Translation.translate_delimiter('12mg', options)).to eq("ملغ 12")

      expect(Translation.translate_delimiter('12.500g', options)).to eq("غ 12.500")
      expect(Translation.translate_delimiter('12.50g', options)).to eq("غ 12.50")
      expect(Translation.translate_delimiter('12.5g', options)).to eq("غ 12.5")
      expect(Translation.translate_delimiter('12g', options)).to eq("غ 12")
    end

    it "should translate other characters such as newlines" do
      expect(Translation.translate_delimiter(",")).to eq(", ")
      expect(Translation.translate_delimiter(".")).to eq(".")
      expect(Translation.translate_delimiter("\n")).to eq("\n")
      expect(Translation.translate_delimiter("\t")).to eq("\t")
      expect(Translation.translate_delimiter(" ")).to eq(nil)
      expect(Translation.translate_delimiter("Invalid Delimiter")).to eq(nil)

      options = {input_language: "ENGLISH", output_language: "ARABIC"}
      expect(Translation.translate_delimiter(",", options)).to eq(" ،")
      expect(Translation.translate_delimiter(".", options)).to eq(".")
      expect(Translation.translate_delimiter("\n", options)).to eq("\n")
      expect(Translation.translate_delimiter("\t", options)).to eq("\t")
      expect(Translation.translate_delimiter(" ", options)).to eq(nil)
      expect(Translation.translate_delimiter("Invalid Delimiter", options)).to eq(nil)
    end

    it "should translate weights in multiple formats" do

      # English to Arabic
      options = {input_language: "ENGLISH", output_language: "ARABIC"}
      expect(Translation.translate_delimiter("10g", options)).to eq("10غ")
      expect(Translation.translate_delimiter("10gm", options)).to eq("10جم")
      expect(Translation.translate_delimiter("10grams", options)).to eq("10جرامات")
      expect(Translation.translate_delimiter("1gram", options)).to eq("1غرام")

      expect(Translation.translate_delimiter("10 g", options)).to eq("10 غ")
      expect(Translation.translate_delimiter("10 gm", options)).to eq("10 جم")
      expect(Translation.translate_delimiter("10 grams", options)).to eq("10 جرامات")
      expect(Translation.translate_delimiter("1 gram", options)).to eq("1 غرام")

      # English to French
      options = {input_language: "ENGLISH", output_language: "FRENCH"}

      # Arabic to English
      options = {input_language: "ARABIC", output_language: "ENGLISH"}
      expect(Translation.translate_delimiter("غ10", options)).to eq("10g")
      expect(Translation.translate_delimiter("جم10", options)).to eq("10gm")
      expect(Translation.translate_delimiter("جرامات10", options)).to eq("10grams")
      expect(Translation.translate_delimiter("غرام1", options)).to eq("1gram")

      expect(Translation.translate_delimiter("غ 10", options)).to eq("10 g")
      expect(Translation.translate_delimiter("جم 10", options)).to eq("10 gm")
      expect(Translation.translate_delimiter("جرامات 10", options)).to eq("10 grams")
      expect(Translation.translate_delimiter("غرام 1", options)).to eq("1 gram")

      # Arabic to English
      options = {input_language: "ARABIC", output_language: "FRENCH"}
    end

    it "should translate percentage" do

      # English to Arabic
      options = {input_language: "ENGLISH", output_language: "ARABIC"}
      expect(Translation.translate_delimiter("10%", options)).to eq("10%")
      expect(Translation.translate_delimiter("10 %", options)).to eq("10 %")

      # English to French
      options = {input_language: "ENGLISH", output_language: "FRENCH"}
      expect(Translation.translate_delimiter("10%", options)).to eq("10%")
      expect(Translation.translate_delimiter("10 %", options)).to eq("10 %")


      # Arabic to English
      options = {input_language: "ENGLISH", output_language: "ARABIC"}
      expect(Translation.translate_delimiter("10%", options)).to eq("10%")
      expect(Translation.translate_delimiter("10 %", options)).to eq("10 %")

      # Arabic to French
      options = {input_language: "ENGLISH", output_language: "FRENCH"}
      expect(Translation.translate_delimiter("10%", options)).to eq("10%")
      expect(Translation.translate_delimiter("10 %", options)).to eq("10 %")

      # French to English
      options = {input_language: "ENGLISH", output_language: "ARABIC"}
      expect(Translation.translate_delimiter("10%", options)).to eq("10%")
      expect(Translation.translate_delimiter("10 %", options)).to eq("10 %")

      # French to English
      options = {input_language: "ENGLISH", output_language: "FRENCH"}
      expect(Translation.translate_delimiter("10%", options)).to eq("10%")
      expect(Translation.translate_delimiter("10 %", options)).to eq("10 %")
 
    end
  end

end

# Input text for reference
# التفاح والمانجو والعنب.

# English Example
# ---------------


# Translate commas and 'and'

# Apple, Mango and Grape
# Apple or Mango
# Apple.

# Translate gm, grams and gms without round brackets

# 12.500gm Apple, 12.5gm Apple, 1g Apple.
# 12.500grams Apple, 12.5grams Apple, 1gram Apple.
# 12.500gms Apple, 12.5gms Apple and 12gms Apple.

# 12.500 gm Apple, 12.5 gm Apple, 1 gm Apple.
# 12.500 grams Apple, 12.5 grams Apple, 1 gram Apple.
# 12.500 gms Apple, 12.5 gms Apple and 12 gms Apple.

# Apple 12.500 grams, Apple 12.5 grams and Apple 12 grams.
# Apple 12.500 gms, Apple 12.5 gms and Apple 12 gms.
# Apple 12.500 gm, Apple 12.5 gm and Apple 12 g.

# Translate gm, grams and gms with round brackets

# (12.500gm) Apple, (12.5gm) Apple, (1gm) Apple.
# (12.500grams) Apple, (12.5grams) Apple, (1gram) Apple.
# (12.500gms) Apple, (12.5gms) Apple and (12gms) Apple.

# (12.500 gm) Apple, (12.5 gm) Apple, (1 gm) Apple.
# (12.500 grams) Apple, (12.5 grams) Apple, (1 gram) Apple.
# (12.500 gms) Apple, (12.5 gms) Apple and (12 gms) Apple.

# Apple (12.500 grams), Apple (12.5 grams) and Apple (12 grams).
# Apple (12.500 gms), Apple (12.5 gms) and Apple (12 gms).
# Apple (12.500 gm), Apple (12.5 gm) and Apple (12 g).

