require 'rails_helper'
require './spec/models/concerns/00_context.rb'

RSpec.describe Translation, type: :model do

  include_context 'dataset'

  context "Translate with Score" do
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

  context "More Practical Cases" do
    it "should calculate score for all practical cases" do

      skip
      
      # TODO - FIXME do like above for the below inputs

      # gm, grams and gms without round brackets
      expect(Translation.tokenize('12.500gm Apple, 12.5gm Apple, 1g Apple.').size).to be 8
      expect(Translation.tokenize('12.500grams Apple, 12.5grams Apple, 1gram Apple.').size).to be 8
      expect(Translation.tokenize('12.500gms Apple, 12.5gms Apple and 12gms Apple.').size).to be 9

      # 12.500 gm Apple, 12.5 gm Apple, 1 gm Apple.
      # 12.500 grams Apple, 12.5 grams Apple, 1 gram Apple.
      # 12.500 gms Apple, 12.5 gms Apple and 12 gms Apple.

      # Apple 12.500 grams, Apple 12.5 grams and Apple 12 grams.
      # Apple 12.500 gms, Apple 12.5 gms and Apple 12 gms.
      # Apple 12.500 gm, Apple 12.5 gm and Apple 12 g.

      # gm, grams and gms with round brackets

      # (12.500gm) Apple, (12.5gm) Apple, (1gm) Apple.
      # (12.500grams) Apple, (12.5grams) Apple, (1gram) Apple.
      # (12.500gms) Apple, (12.5gms) Apple and (12gms) Apple.

      # (12.500 gm) Apple, (12.5 gm) Apple, (1 gm) Apple.
      # (12.500 grams) Apple, (12.5 grams) Apple, (1 gram) Apple.
      # (12.500 gms) Apple, (12.5 gms) Apple and (12 gms) Apple.

      # Apple (12.500 grams), Apple (12.5 grams) and Apple (12 grams).
      # Apple (12.500 gms), Apple (12.5 gms) and Apple (12 gms).
      # Apple (12.500 gm), Apple (12.5 gm) and Apple (12 g).

    end
  end

end

