require 'rails_helper'
require './spec/models/concerns/00_context.rb'

RSpec.describe Translation, type: :model do

  include_context 'dataset'

  context "Token Translator & Stitcher" do

    it "should translate token for simple words" do
      scores_hash = Translation.translate_token('Sodium Chloride')
      expect(scores_hash['SodiumChloride'][:score]).to eq(0)
      expect(scores_hash['SodiumChloride'][:translation]).to eq('كلوريد الصوديوم')
    end

    it "should translate token with units" do

      scores_hash = Translation.translate_token('10grams Mango')
      expect(scores_hash['10 grams'][:score]).to eq(0)
      expect(scores_hash['10 grams'][:translation]).to eq('جرامات 10')
      expect(scores_hash['Mango'][:score]).to eq(0)
      expect(scores_hash['Mango'][:translation]).to eq('مانجو')

      scores_hash = Translation.translate_token('Mango 10grams')
      expect(scores_hash['10 grams'][:score]).to eq(0)
      expect(scores_hash['10 grams'][:translation]).to eq('جرامات 10')
      expect(scores_hash['Mango'][:score]).to eq(0)
      expect(scores_hash['Mango'][:translation]).to eq('مانجو')


      scores_hash = Translation.translate_token('10 grams Mango')
      expect(scores_hash['10 grams'][:score]).to eq(0)
      expect(scores_hash['10 grams'][:translation]).to eq('جرامات 10')
      expect(scores_hash['Mango'][:score]).to eq(0)
      expect(scores_hash['Mango'][:translation]).to eq('مانجو')

      scores_hash = Translation.translate_token('Mango 10 grams')
      expect(scores_hash['10 grams'][:score]).to eq(0)
      expect(scores_hash['10 grams'][:translation]).to eq('جرامات 10')
      expect(scores_hash['Mango'][:score]).to eq(0)
      expect(scores_hash['Mango'][:translation]).to eq('مانجو')
    end

    it "should translate token with percentages" do
      scores_hash = Translation.translate_token('10% Mango')
      expect(scores_hash['10 %'][:score]).to eq(0)
      expect(scores_hash['10 %'][:translation]).to eq('% 10')
      expect(scores_hash['Mango'][:score]).to eq(0)
      expect(scores_hash['Mango'][:translation]).to eq('مانجو')

      scores_hash = Translation.translate_token('Mango 10%')
      expect(scores_hash['10 %'][:score]).to eq(0)
      expect(scores_hash['10 %'][:translation]).to eq('% 10')
      expect(scores_hash['Mango'][:score]).to eq(0)
      expect(scores_hash['Mango'][:translation]).to eq('مانجو')

      scores_hash = Translation.translate_token('10 % Mango')
      expect(scores_hash['10 %'][:score]).to eq(0)
      expect(scores_hash['10 %'][:translation]).to eq('% 10')
      expect(scores_hash['Mango'][:score]).to eq(0)
      expect(scores_hash['Mango'][:translation]).to eq('مانجو')

      scores_hash = Translation.translate_token('Mango 10 %')
      expect(scores_hash['10 %'][:score]).to eq(0)
      expect(scores_hash['10 %'][:translation]).to eq('% 10')
      expect(scores_hash['Mango'][:score]).to eq(0)
      expect(scores_hash['Mango'][:translation]).to eq('مانجو')
    end

    it "should translate token with decimals" do
      # scores_hash = Translation.translate_token('12.500gm Apple')
      # scores_hash = Translation.translate_paragraph('12.500gm Apple')
      # scores_hash = Translation.translate_paragraph('12.5gm Apple')
      # scores_hash = Translation.translate_paragraph('1g Apple')

      scores_hash = Translation.translate_token('10% Mango')
      expect(scores_hash['10 %'][:score]).to eq(0)
      expect(scores_hash['10 %'][:translation]).to eq('% 10')
      expect(scores_hash['Mango'][:score]).to eq(0)
      expect(scores_hash['Mango'][:translation]).to eq('مانجو')

      scores_hash = Translation.translate_token('Mango 10%')
      expect(scores_hash['10 %'][:score]).to eq(0)
      expect(scores_hash['10 %'][:translation]).to eq('% 10')
      expect(scores_hash['Mango'][:score]).to eq(0)
      expect(scores_hash['Mango'][:translation]).to eq('مانجو')

      scores_hash = Translation.translate_token('10 % Mango')
      expect(scores_hash['10 %'][:score]).to eq(0)
      expect(scores_hash['10 %'][:translation]).to eq('% 10')
      expect(scores_hash['Mango'][:score]).to eq(0)
      expect(scores_hash['Mango'][:translation]).to eq('مانجو')

      scores_hash = Translation.translate_token('Mango 10 %')
      expect(scores_hash['10 %'][:score]).to eq(0)
      expect(scores_hash['10 %'][:translation]).to eq('% 10')
      expect(scores_hash['Mango'][:score]).to eq(0)
      expect(scores_hash['Mango'][:translation]).to eq('مانجو')
    end

    it "should translate token with conjunctions" do
      scores_hash = Translation.translate_token('10 grams of Sodium Chloride')
      expect(scores_hash['10 grams'][:score]).to eq(0)
      expect(scores_hash['10 grams'][:translation]).to eq('جرامات 10')
      expect(scores_hash['SodiumChloride'][:score]).to eq(0)
      expect(scores_hash['SodiumChloride'][:translation]).to eq('كلوريد الصوديوم')

      scores_hash = Translation.translate_token('10% of Sodium Chloride')
      expect(scores_hash['10 %'][:score]).to eq(0)
      expect(scores_hash['10 %'][:translation]).to eq('% 10')
      expect(scores_hash['SodiumChloride'][:score]).to eq(0)
      expect(scores_hash['SodiumChloride'][:translation]).to eq('كلوريد الصوديوم')

      scores_hash = Translation.translate_token('Buttermilk Powder', output_language: "FRENCH")
      expect(scores_hash['ButtermilkPowder'][:score]).to eq(0)
      expect(scores_hash['ButtermilkPowder'][:translation]).to eq("Poudre de papillon")
    end  
  end

  context "More Practical Cases" do
    it "should translate all practical cases" do

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

