require 'rails_helper'
require './spec/models/concerns/00_context.rb'

RSpec.describe Translation, type: :model do

  include_context 'dataset'

  context "Unit Handler" do
    
    it "should split the input with units and calculate score" do
      unit_scores = Translation.split_units('10 grams of Sodium Chloride')
      expect(unit_scores['10 grams'][:score]).to eq(0)
      expect(unit_scores['10 grams'][:translation]).to eq('جرامات 10')
      expect(unit_scores['of']).to be_nil
      expect(unit_scores['Sodium Chloride']).to be_nil

      unit_scores = Translation.split_units('10 g of Sodium Chloride')
      expect(unit_scores['10 g'][:score]).to eq(0)
      expect(unit_scores['10 g'][:translation]).to eq('غ 10')
      expect(unit_scores['of']).to be_nil
      expect(unit_scores['Sodium Chloride']).to be_nil
      
      unit_scores = Translation.split_units('10grams of Sodium Chloride')
      expect(unit_scores['10 grams'][:score]).to eq(0)
      expect(unit_scores['10 grams'][:translation]).to eq('جرامات 10')
      expect(unit_scores['of']).to be_nil
      expect(unit_scores['Sodium Chloride']).to be_nil

      unit_scores = Translation.split_units('10g of Sodium Chloride')
      expect(unit_scores['10 g'][:score]).to eq(0)
      expect(unit_scores['10 g'][:translation]).to eq('غ 10')
      expect(unit_scores['of']).to be_nil
      expect(unit_scores['Sodium Chloride']).to be_nil
    end

    it "should handle decimals with units" do

      unit_scores = Translation.split_units('1.50 grams mango')
      expect(unit_scores['1.50 grams'][:score]).to eq(0)
      expect(unit_scores['1.50 grams'][:translation]).to eq('جرامات 1.50')
      expect(unit_scores['mango']).to be_nil

      unit_scores = Translation.split_units('1.50 grams of mango')
      expect(unit_scores['1.50 grams'][:score]).to eq(0)
      expect(unit_scores['1.50 grams'][:translation]).to eq('جرامات 1.50')
      expect(unit_scores['of']).to be_nil
      expect(unit_scores['mango']).to be_nil

      
      unit_scores = Translation.split_units('1.50grams mango')
      expect(unit_scores['1.50 grams'][:score]).to eq(0)
      expect(unit_scores['1.50 grams'][:translation]).to eq('جرامات 1.50')
      expect(unit_scores['mango']).to be_nil

      unit_scores = Translation.split_units('1.50grams of mango')
      expect(unit_scores['1.50 grams'][:score]).to eq(0)
      expect(unit_scores['1.50 grams'][:translation]).to eq('جرامات 1.50')
      expect(unit_scores['of']).to be_nil
      expect(unit_scores['mango']).to be_nil


      unit_scores = Translation.split_units('mango 1.50 grams')
      expect(unit_scores['1.50 grams'][:score]).to eq(0)
      expect(unit_scores['1.50 grams'][:translation]).to eq('جرامات 1.50')
      expect(unit_scores['mango']).to be_nil

      unit_scores = Translation.split_units('mango 1.50grams')
      expect(unit_scores['1.50 grams'][:score]).to eq(0)
      expect(unit_scores['1.50 grams'][:translation]).to eq('جرامات 1.50')
      expect(unit_scores['mango']).to be_nil
    end

    it "should handle percentages well" do
      unit_scores = Translation.split_units('Mango 10%')
      expect(unit_scores['10 %'][:score]).to eq(0)
      expect(unit_scores['10 %'][:translation]).to eq('% 10')
      expect(unit_scores['mango']).to be_nil

      unit_scores = Translation.split_units('10% Mango')
      expect(unit_scores['10 %'][:score]).to eq(0)
      expect(unit_scores['10 %'][:translation]).to eq('% 10')
      expect(unit_scores['mango']).to be_nil


      unit_scores = Translation.split_units('Mango 10 %')
      expect(unit_scores['10 %'][:score]).to eq(0)
      expect(unit_scores['10 %'][:translation]).to eq('% 10')
      expect(unit_scores['mango']).to be_nil

      unit_scores = Translation.split_units('10 % Mango')
      expect(unit_scores['10 %'][:score]).to eq(0)
      expect(unit_scores['10 %'][:translation]).to eq('% 10')
      expect(unit_scores['mango']).to be_nil
    end
  end

  context "More Practical Cases" do
    it "should handle the units for all practical cases" do

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

