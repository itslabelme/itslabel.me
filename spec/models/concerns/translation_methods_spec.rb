require 'rails_helper'

RSpec.describe Translation, type: :model do

  before :each do
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "Apple", output_phrase: "تفاحة")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "Mango", output_phrase: "مانجو")
    FactoryBot.create(:english_to_arabic_translation, input_phrase: "Grapes", output_phrase: "عنب")

    FactoryBot.create(:english_to_french_translation, input_phrase: "Apple", output_phrase: "Pomme")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Mango", output_phrase: "Mangue")
    FactoryBot.create(:english_to_french_translation, input_phrase: "Grapes", output_phrase: "Les Raisins")

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

  context "Basic Translations" do
    
    it "should translate a single word (single word or seperated with spaces) " do
      expect(Translation.translate_word('Apple')).to eq('تفاحة')
      expect(Translation.translate_word('Mango')).to eq('مانجو')
      expect(Translation.translate_word('Grapes')).to eq('عنب')
      expect(Translation.translate_word('No Word')).to eq(nil)

      expect(Translation.translate_word('Apple', input_language: "ENGLISH", output_language: "ARABIC")).to eq('تفاحة')
      expect(Translation.translate_word('Mango', input_language: "ENGLISH", output_language: "ARABIC")).to eq('مانجو')
      expect(Translation.translate_word('Grapes', input_language: "ENGLISH", output_language: "ARABIC")).to eq('عنب')
      expect(Translation.translate_word('No Word', input_language: "ENGLISH", output_language: "ARABIC")).to eq(nil)

      expect(Translation.translate_word('Apple', output_language: "FRENCH")).to eq('Pomme')
      expect(Translation.translate_word('Mango', output_language: "FRENCH")).to eq('Mangue')
      expect(Translation.translate_word('Grapes', output_language: "FRENCH")).to eq('Les Raisins')
      expect(Translation.translate_word('No Word', output_language: "FRENCH")).to eq(nil)
    end

    it "should translate an array of words" do
      # Arabic
      expect(Translation.translate_words(['Apple', 'Mango'])).to include(
        "Apple" => 'تفاحة',
        "Mango" => 'مانجو',
      )
      expect(Translation.translate_words(['Grapes', 'Mango'])).to include(
        "Grapes" => 'عنب',
        "Mango" => 'مانجو',
      )
      expect(Translation.translate_words(['Grapes', 'No Word'])).to include(
        "Grapes" => 'عنب',
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
      expect(Translation.translate('Grapes')).to eq('عنب')
      expect(Translation.translate('No Word')).to eq("No Word")

      expect(Translation.translate(['Apple', 'Mango'])).to include(
        "Apple" => 'تفاحة',
        "Mango" => 'مانجو',
      )
      expect(Translation.translate(['Grapes', 'Mango'])).to include(
        "Grapes" => 'عنب',
        "Mango" => 'مانجو',
      )
      expect(Translation.translate(['Grapes', 'No Word'])).to include(
        "Grapes" => 'عنب',
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

end