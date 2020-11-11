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

  context "Tokenizer" do
    
    it "should split the input with units and calculate score" do
      unit_scores = Translation.split_units('10 grams of Sodium Chloride')
      expect(unit_scores['10'][:score]).to eq(nil)
      expect(unit_scores['grams'][:score]).to eq(0)
      expect(unit_scores['grams'][:translation]).to eq('جرامات')

      unit_scores = Translation.split_units('10 g of Sodium Chloride')
      expect(unit_scores['10'][:score]).to eq(nil)
      expect(unit_scores['g'][:score]).to eq(0)
      expect(unit_scores['g'][:translation]).to eq('غ')

      unit_scores = Translation.split_units('10grams of Sodium Chloride')
      expect(unit_scores['10'][:score]).to eq(nil)
      expect(unit_scores['grams'][:score]).to eq(0)
      expect(unit_scores['grams'][:translation]).to eq('جرامات')

      unit_scores = Translation.split_units('10g of Sodium Chloride')
      expect(unit_scores['10'][:score]).to eq(nil)
      expect(unit_scores['g'][:score]).to eq(0)
      expect(unit_scores['g'][:translation]).to eq('غ')
    end

    it "should tokenize the input with delimitters" do
      tokens = Translation.tokenize('10 grams of Sodium Chloride; Apple, Mango and Grapes;')
      expect(tokens[0]).to eq('10 grams')
      expect(tokens[1]).to eq(' ')
      expect(tokens[2]).to eq('of')
      expect(tokens[3]).to eq(' ')
      expect(tokens[4]).to eq('Sodium Chloride')
      expect(tokens[5]).to eq(';')
      expect(tokens[6]).to eq(' ')
      expect(tokens[7]).to eq('Apple')
      expect(tokens[8]).to eq(',')
      expect(tokens[9]).to eq(' ')
      expect(tokens[10]).to eq('Mango')
      expect(tokens[11]).to eq(' ')
      expect(tokens[12]).to eq('and')
      expect(tokens[13]).to eq(' ')
      expect(tokens[14]).to eq('Grapes')
      expect(tokens[15]).to eq(';')
    end

    it "should translate token" do
      scores_hash = Translation.translate_token('10 grams Sodium Chloride')
      
      expect(scores_hash['10'][:score]).to eq(nil)
      
      expect(scores_hash['grams'][:score]).to eq(0)
      expect(scores_hash['grams'][:translation]).to eq('جرامات')
      
      expect(scores_hash['Sodium Chloride'][:score]).to eq(0)
      expect(scores_hash['Sodium Chloride'][:translation]).to eq('كلوريد الصوديوم')


      scores_hash = Translation.translate_token('Buttermilk Powder', output_language: "FRENCH")
      expect(scores_hash['Buttermilk Powder'][:score]).to eq(0)
      expect(scores_hash['Buttermilk Powder'][:translation]).to eq("Poudre de papillon")
    end

    it "should stitch scores back" do
      scores = { "10"=>{:score=>nil},
                 "grams"=>{:score=>0, :translation=>"جرامات"},
                 "of"=>{:score=>0, :translation=>"من"},
                 "SodiumChloride"=>{:score=>0, :translation=>"كلوريد الصوديوم"}
               }
      expect(Translation.stitch_token(scores)).to eq('كلوريد الصوديوم من جرامات 10')
    end
  end

  context "Single Word Translations" do
    it "should translate a single word from english to arabic " do
      expect(Translation.translate_word_with_score('Apple')[:translation]).to eq('تفاحة')
      expect(Translation.translate_word_with_score('Mango')[:translation]).to eq('مانجو')
      expect(Translation.translate_word_with_score('Grapes')[:translation]).to eq('العنب')
      expect(Translation.translate_word_with_score('No Word').try(:[], :translation)).to eq(nil)

      expect(Translation.translate_word_with_score('Apple', input_language: "ENGLISH", output_language: "ARABIC")[:translation]).to eq('تفاحة')
      expect(Translation.translate_word_with_score('Mango', input_language: "ENGLISH", output_language: "ARABIC")[:translation]).to eq('مانجو')
      expect(Translation.translate_word_with_score('Grapes', input_language: "ENGLISH", output_language: "ARABIC")[:translation]).to eq('العنب')
      expect(Translation.translate_word_with_score('No Word', input_language: "ENGLISH", output_language: "ARABIC")[:translation]).to eq(nil)
    end

    it "should translate a single word from english to french " do
      expect(Translation.translate_word_with_score('Apple', input_language: "ENGLISH", output_language: "FRENCH")[:translation]).to eq('Pomme')
      expect(Translation.translate_word_with_score('Mango', input_language: "ENGLISH", output_language: "FRENCH")[:translation]).to eq('Mangue')
      expect(Translation.translate_word_with_score('Grapes', input_language: "ENGLISH", output_language: "FRENCH")[:translation]).to eq('Les Raisins')
      expect(Translation.translate_word_with_score('No Word', input_language: "ENGLISH", output_language: "FRENCH")[:translation]).to eq(nil)
    end
    
    it "should translate a single word from arabic to english" do
      expect(Translation.translate_word_with_score('تفاحة', input_language: "ARABIC", output_language: "ENGLISH")[:translation]).to eq('Apple')
      expect(Translation.translate_word_with_score('مانجو', input_language: "ARABIC", output_language: "ENGLISH")[:translation]).to eq('Mango')
      expect(Translation.translate_word_with_score('العنب', input_language: "ARABIC", output_language: "ENGLISH")[:translation]).to eq('Grapes')
      expect(Translation.translate_word_with_score('No Word', input_language: "ARABIC", output_language: "ENGLISH")[:translation]).to eq(nil)
    end

    it "should translate a single word from arabic to french" do
      expect(Translation.translate_word_with_score('تفاحة', input_language: "ARABIC", output_language: "FRENCH")[:translation]).to eq('Pomme')
      expect(Translation.translate_word_with_score('مانجو', input_language: "ARABIC", output_language: "FRENCH")[:translation]).to eq('Mangue')
      expect(Translation.translate_word_with_score('العنب', input_language: "ARABIC", output_language: "FRENCH")[:translation]).to eq('Les Raisins')
      expect(Translation.translate_word_with_score('بببب', input_language: "ARABIC", output_language: "FRENCH")[:translation]).to eq(nil)
    end

    it "should translate a single word from french to english " do
      expect(Translation.translate_word_with_score('Pomme', input_language: "FRENCH", output_language: "ENGLISH")[:translation]).to eq('Apple')
      expect(Translation.translate_word_with_score('Mangue', input_language: "FRENCH", output_language: "ENGLISH")[:translation]).to eq('Mango')
      expect(Translation.translate_word_with_score('Les Raisins', input_language: "FRENCH", output_language: "ENGLISH")[:translation]).to eq('Grapes')
      expect(Translation.translate_word_with_score('No Word', input_language: "FRENCH", output_language: "ENGLISH")[:translation]).to eq(nil)
    end

    it "should translate a single word from french to arabic " do
      expect(Translation.translate_word_with_score('Pomme', input_language: "FRENCH", output_language: "ARABIC")[:translation]).to eq('تفاحة')
      expect(Translation.translate_word_with_score('Mangue', input_language: "FRENCH", output_language: "ARABIC")[:translation]).to eq('مانجو')
      expect(Translation.translate_word_with_score('Les Raisins', input_language: "FRENCH", output_language: "ARABIC")[:translation]).to eq('العنب')
      expect(Translation.translate_word_with_score('No Word', input_language: "FRENCH", output_language: "ARABIC")[:translation]).to eq(nil)
    end
  end

  context "Simple Translation" do
    
    it "should translate simple words" do
      expect(Translation.translate('10 grams Sodium Chloride')).to eq('كلوريد الصوديوم جرامات 10')
      expect(Translation.translate('Apple')).to eq('تفاحة')
      expect(Translation.translate('Mango')).to eq('مانجو')
      expect(Translation.translate('Grapes')).to eq('العنب')
    end

    it "should handle words not in database " do
      expect(Translation.translate('No Word')).to eq("No Word")
      expect(Translation.translate('Hello World', input_language: "ENGLISH", output_language: "ARABIC")).to eq('Hello World')
      expect(Translation.translate('No Word', input_language: "ENGLISH", output_language: "FRENCH")).to eq('No Word')
      expect(Translation.translate('XXX', input_language: "FRENCH", output_language: "ENGLISH")).to eq('XXX')
      expect(Translation.translate('بببب', input_language: "ARABIC", output_language: "ENGLISH")).to eq('بببب')
    end

    it "should handle case differences" do
      expect(Translation.translate('APPLE')).to eq('تفاحة')
      expect(Translation.translate('apple')).to eq('تفاحة')
      expect(Translation.translate('AppLE')).to eq('تفاحة')

      expect(Translation.translate('SODIUM CHORIDE')).to eq('كلوريد الصوديوم')
      expect(Translation.translate('sodium chloride')).to eq('كلوريد الصوديوم')
      expect(Translation.translate('SODIUM Chloride')).to eq('كلوريد الصوديوم')
      expect(Translation.translate('sodlium CHLORIDE')).to eq('كلوريد الصوديوم')
      expect(Translation.translate('SoDiUm ChLoRiDe')).to eq('كلوريد الصوديوم')
    end

    it "should handle missing characters" do
      expect(Translation.translate('AplE')).to eq('تفاحة')
      expect(Translation.translate('Appl')).to eq('تفاحة')

      expect(Translation.translate('SoDUM CHlORiDE')).to eq('كلوريد الصوديوم')
      expect(Translation.translate('soium chloride')).to eq('كلوريد الصوديوم')
      expect(Translation.translate('SODIUM Chlorde')).to eq('كلوريد الصوديوم')
      expect(Translation.translate('sodliam CHLORIDE')).to eq('كلوريد الصوديوم')
      expect(Translation.translate('SoDiem ChLaRiDe')).to eq('كلوريد الصوديوم')
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

      # input_paragraph = "Corn, Vegetable Oils, Cheese Powder (Milk), Salt, Buttermilk Powder (Milk), Wheat Flour, Whey Protein, Concentrate (Milk), Tomato Powder, Flavour Enhancers, (621,631,627), Onion Powder, Whey Powder (Milk), Garlic Powder, Dextrose, Sugar, NAtural Flavour, Mineral, Salt (339), Food Acids (Lactic Acid, Citric Acid), Spice (Whitepepper), Colours (110, 150D)."
      # expect(Translation.translate_paragraph(input_paragraph, return_in_hash: true, output_language: "FRENCH")).to include(
      #   "Corn" => "blé",
      #   "," => nil,
      #   "" => "",
      #   "Vegetable Oils" => "Les Huiles végétales",
      #   "Cheese Powder" => "Poudre de fromage",
      #   "(" => nil,
      #   "Milk" => "Lait",
      #   ")" => nil,
      #   "Salt" => "Sel",
      #   "Buttermilk Powder" => "Poudre de papillon",
      #   "Wheat Flour" => "Farine de blé",
      #   "Whey Protein" => "Protéine de whey",
      #   "Concentrate" => "Concentrer",
      #   "Tomato Powder" => "Poudre de tomate",
      #   "Flavour Enhancers" => "Exhausteurs de goût",
      #   "621" => nil,
      #   "631" => nil,
      #   "627" => nil,
      #   "Onion Powder" => "Poudre d'oignon",
      #   "Whey Powder" => "La poudre de lactosérum",
      #   "Garlic Powder" => "Poudre d'ail",
      #   "Dextrose" => "Dextrose",
      #   "Sugar" => "Sucre",
      #   "NAtural Flavour" => "Saveur naturelle",
      #   "Mineral" => "Minéral",
      #   "339" => nil,
      #   "Food Acids" => "Acides alimentaires",
      #   "Lactic Acid" => "Acide lactique",
      #   "Citric Acid" => "Acide citrique",
      #   "Spice" => "Pimenter",
      #   "Whitepepper" => "Poivre blanc",
      #   "Colours" => "Couleurs",
      #   "110" => nil,
      #   "150D" => nil,
      #   "." => nil
      # )

      # Trying out Capital Letters
      input_paragraph = "CORN, VEGETABLE OILS, CHEESE POWDER (MILK), SALT, BUTTERMILK POWDER (MILK), WHEAT FLOUR, WHEY PROTEIN, CONCENTRATE (MILK), TOMATO POWDER, FLAVOUR ENHANCERS, (621,631,627),ONION POWDER, WHEY POWDER (MILK), GARLIC POWDER, DEXTROSE, SUGAR, NATURAL FLAVOUR, MINIERAL, SALT (339), FOOD ACIDS (LACTIC ACID, CITRIC ACID), SPICE (WHITEPEPPER), COLOURS (110, 150D)."
      # expect(Translation.translate_paragraph(input_paragraph, return_in_hash: true, output_language: "FRENCH")).to include(
      #   "CORN" => 'blé',
      #   "COLOURS" => 'Couleurs',
      # )
      # output_paragraph = %{
      #   blé, Les Huiles végétales, Poudre de fromage (Lait), Sel,
      #   BUTTERLait POWDER (Lait), Farine de blé, Protéine de whey,
      #   Concentrer (Lait), Poudre de tomate, Exhausteurs de goût,
      #   (621,631,627),Poudre d'oignon, La poudre de lactosérum (Lait),
      #   Poudre d'ail, Dextrose, Sucre, Saveur naturelle,
      #   Minéral, Sel (339), Acides alimentaires (Acide lactique, Acide citrique),
      #   Pimenter (Poivre blanc), Couleurs (110, 150D).
      # }

      #actual_output_to_be = "blé, Les Huiles végétales, Poudre de fromage (Lait), Sel, Poudre de papillon (Lait), Farine de blé, Protéine de whey, Concentrer (Lait), Poudre de tomate, Exhausteurs de goût, (621,631,627), Poudre d'oignon, La poudre de lactosérum (Lait), Poudre d'ail, Dextrose, Sucre, Saveur naturelle, Minéral, Sel (339), Acides alimentaires (Acide lactique, Acide citrique), Pimenter (Poivre blanc), Couleurs (110, 150D)."
      desired_output = "blé, Les Huiles végétales, Poudre de fromage (Lait), Sel, Poudre de papillon (Lait), Farine de blé, Protéine de whey, Concentrer (Lait), Poudre de tomate, Exhausteurs de goût, (621,631,627), Poudre d'oignon, La poudre de lactosérum (Lait), Poudre d'ail, Dextrose, Sucre, Saveur naturelle, Minéral, SALT (339), Acides alimentaires (Acide lactique, Acide citrique), Pimenter (Poivre blanc), Couleurs (110, 150D)."
      real_output = Translation.translate_paragraph(input_paragraph, output_language: "FRENCH")
      expect(desired_output).to eq(real_output)
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
      binding.pry
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

