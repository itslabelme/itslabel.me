require 'rails_helper'
require './spec/models/concerns/00_context.rb'

RSpec.describe Translation, type: :model do

  # include_context 'dataset'

  context "should handle all types of delimitters" do
    
    it "should tokenize the input with delimitters properly" do
      # No Delimitter
      tokens = Translation.tokenize('Apple')
      expect(tokens[0]).to eq('Apple')

      # Delimitter - . (dot)
      tokens = Translation.tokenize('Apple.')
      expect(tokens[0]).to eq('Apple')
      expect(tokens[1]).to eq('.')
      
      # Delimitter - Brackets
      tokens = Translation.tokenize('(Apple)')
      expect(tokens[0]).to eq('(')
      expect(tokens[1]).to eq('Apple')
      expect(tokens[2]).to eq(')')

      tokens = Translation.tokenize('[Apple]')
      expect(tokens[0]).to eq('[')
      expect(tokens[1]).to eq('Apple')
      expect(tokens[2]).to eq(']')

      tokens = Translation.tokenize('{Apple}')
      expect(tokens[0]).to eq('{')
      expect(tokens[1]).to eq('Apple')
      expect(tokens[2]).to eq('}')
    end

    it "should tokenize the input with conjunctions properly" do
      
      # Conjunction - and
      tokens = Translation.tokenize('Apple and Mango')
      expect(tokens[0]).to eq('Apple and Mango')
      
      # Conjunction - &
      tokens = Translation.tokenize('Apple & Mango')
      expect(tokens[0]).to eq('Apple & Mango')
      
      # Conjunction - or
      tokens = Translation.tokenize('Apple or Mango')
      expect(tokens[0]).to eq('Apple or Mango')
      
      # Conjunction - of
      tokens = Translation.tokenize('Pinch of Salt')
      expect(tokens[0]).to eq('Pinch of Salt')
      
      # Conjunction - Without
      tokens = Translation.tokenize('Coffee with Sugar, Cream and Milk')
    end

    it "should tokenize the input with units properly" do
      # Unit - before word
      expect(Translation.tokenize('1kg Apple').size).to be 1
      expect(Translation.tokenize('10 kg Apple').size).to be 1

      # Unit - after word
      expect(Translation.tokenize('Apple 1kg').size).to be 1
      expect(Translation.tokenize('Apple 10 kg').size).to be 1

      # Unit with Conjunction
      expect(Translation.tokenize('1kg of Apple').size).to be 1
      
      # Unit with brackets and other characters
      expect(Translation.tokenize('Apple (1kg)').size).to be 5
      expect(Translation.tokenize('Apple (1 kg)').size).to be 5
      expect(Translation.tokenize('Apple: 1kg').size).to be 4
      expect(Translation.tokenize('Apple: 1 kg').size).to be 4
    end

    it "should tokenize the % properly" do
      
      # % - before word
      expect(Translation.tokenize('10% Apple').size).to be 1
      expect(Translation.tokenize('10 % Apple').size).to be 1

      # % - after word
      expect(Translation.tokenize('Apple 10%').size).to be 1
      expect(Translation.tokenize('Apple 10 %').size).to be 1

      # % with Conjunction
      expect(Translation.tokenize('Apple 10% and Mango 90%').size).to be 1
      
      # % with brackets
      expect(Translation.tokenize('Apple (10%)').size).to be 5
      expect(Translation.tokenize('Apple (10 %)').size).to be 5
      expect(Translation.tokenize('Apple: 1%').size).to be 4
      expect(Translation.tokenize('Apple: 2 %').size).to be 4

      # All Combinations
      expect(Translation.tokenize('Apple 10%, 20% Mango (with  30% Grapes)').size).to be 8
    end

    it "should tokenize the input with all combinations" do
      
      input = """1 kg Flour;
      10 grams Baking Powder:
      10 oz Butter and 1 kilo Sugar (Powdered).
      0.5 litre Milk with 20% water;
      10 ml Vinegar;
      E420 or Vanilla Essence;"""
      
      tokens = Translation.tokenize(input)

      expect(tokens[0]).to eq("1 kg Flour")
      expect(tokens[1]).to eq(";")
      expect(tokens[2]).to eq(" ")
      expect(tokens[3]).to eq("10 grams Baking Powder")
      expect(tokens[4]).to eq(":")
      expect(tokens[5]).to eq(" ")
      expect(tokens[6]).to eq("10 oz Butter and 1 kilo Sugar")
      expect(tokens[7]).to eq(" ")
      expect(tokens[8]).to eq("(")
      expect(tokens[9]).to eq("Powdered")
      expect(tokens[10]).to eq(")")
      expect(tokens[11]).to eq(".")
      expect(tokens[12]).to eq(" ")
      expect(tokens[13]).to eq("0.5 litre Milk with 20% water")
      expect(tokens[14]).to eq(";")
      expect(tokens[15]).to eq(" ")
      expect(tokens[16]).to eq("10 ml Vinegar")
      expect(tokens[17]).to eq(";")
      expect(tokens[18]).to eq(" ")
      expect(tokens[19]).to eq("E420 or Vanilla Essence")
      expect(tokens[20]).to eq(";")

      tokens = Translation.tokenize('10 grams of Sodium Chloride with 1g Apple, Mango(2kg) and Grapes 3kg; 1 litre water')
      
      expect(tokens[0]).to eq("10 grams of Sodium Chloride with 1g Apple")
      expect(tokens[1]).to eq(",")
      expect(tokens[2]).to eq(" ")
      expect(tokens[3]).to eq("Mango")
      expect(tokens[4]).to eq("(")
      expect(tokens[5]).to eq("2kg")
      expect(tokens[6]).to eq(")")
      expect(tokens[7]).to eq(" ")
      expect(tokens[8]).to eq("and Grapes 3kg")
      expect(tokens[9]).to eq(";")
      expect(tokens[10]).to eq(" ")
      expect(tokens[11]).to eq("1 litre water")
    end
  end

  context "More Practical Cases" do
    it "should tokenize the input for all practical cases" do

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
