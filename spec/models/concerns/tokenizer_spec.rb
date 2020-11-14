require 'rails_helper'

RSpec.describe Translation, type: :model do

  context "Delimitters" do
    
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
      expect(tokens[0]).to eq('Apple')
      expect(tokens[1]).to eq(' ')
      expect(tokens[2]).to eq('and')
      expect(tokens[3]).to eq(' ')
      expect(tokens[4]).to eq('Mango')

      # Conjunction - &
      tokens = Translation.tokenize('Apple & Mango')
      expect(tokens[0]).to eq('Apple')
      expect(tokens[1]).to eq(' ')
      expect(tokens[2]).to eq('&')
      expect(tokens[3]).to eq(' ')
      expect(tokens[4]).to eq('Mango')

      # Conjunction - or
      tokens = Translation.tokenize('Apple or Mango')
      expect(tokens[0]).to eq('Apple')
      expect(tokens[1]).to eq(' ')
      expect(tokens[2]).to eq('or')
      expect(tokens[3]).to eq(' ')
      expect(tokens[4]).to eq('Mango')

      # Conjunction - of
      tokens = Translation.tokenize('Pinch of Salt')
      expect(tokens[0]).to eq('Pinch')
      expect(tokens[1]).to eq(' ')
      expect(tokens[2]).to eq('of')
      expect(tokens[3]).to eq(' ')
      expect(tokens[4]).to eq('Salt')

      # Conjunction - Without
      tokens = Translation.tokenize('Coffee with Sugar, Cream and Milk')
      expect(tokens[0]).to eq('Coffee')
      expect(tokens[1]).to eq(' ')
      expect(tokens[2]).to eq('with')
      expect(tokens[3]).to eq(' ')
      expect(tokens[4]).to eq('Sugar')
      expect(tokens[5]).to eq(',')
      expect(tokens[6]).to eq(' ')
      expect(tokens[7]).to eq('Cream')
      expect(tokens[8]).to eq(' ')
      expect(tokens[9]).to eq('and')
      expect(tokens[10]).to eq(' ')
      expect(tokens[11]).to eq('Milk')
    end

    it "should tokenize the input with units properly" do
      
      # Unit - before word
      expect(Translation.tokenize('1kg Apple').size).to be 1
      expect(Translation.tokenize('10 kg Apple').size).to be 1

      # Unit - after word
      expect(Translation.tokenize('Apple 1kg').size).to be 1
      expect(Translation.tokenize('Apple 10 kg').size).to be 1

      # Unit with Conjunction
      expect(Translation.tokenize('1kg of Apple').size).to be 5
      
      # Unit with brackets and other characters
      expect(Translation.tokenize('Apple (1kg)').size).to be 5
      expect(Translation.tokenize('Apple (1 kg)').size).to be 5
      expect(Translation.tokenize('Apple: 1kg').size).to be 4
      expect(Translation.tokenize('Apple: 1 kg').size).to be 4
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
      expect(tokens[6]).to eq("10 oz Butter")
      expect(tokens[7]).to eq(" ")
      expect(tokens[8]).to eq("and")
      expect(tokens[9]).to eq(" ")
      expect(tokens[10]).to eq("1 kilo Sugar")
      expect(tokens[11]).to eq(" ")
      expect(tokens[12]).to eq("(")
      expect(tokens[13]).to eq("Powdered")
      expect(tokens[14]).to eq(")")
      expect(tokens[15]).to eq(".")
      expect(tokens[16]).to eq(" ")
      expect(tokens[17]).to eq("0.5 litre Milk")
      expect(tokens[18]).to eq(" ")
      expect(tokens[19]).to eq("with")
      expect(tokens[20]).to eq(" ")
      expect(tokens[21]).to eq("20% water")
      expect(tokens[22]).to eq(";")
      expect(tokens[23]).to eq(" ")
      expect(tokens[24]).to eq("10 ml Vinegar")
      expect(tokens[25]).to eq(";")
      expect(tokens[26]).to eq(" ")
      expect(tokens[27]).to eq("E420")
      expect(tokens[28]).to eq(" ")
      expect(tokens[29]).to eq("or")
      expect(tokens[30]).to eq(" ")
      expect(tokens[31]).to eq("Vanilla Essence")
      expect(tokens[32]).to eq(";")


      tokens = Translation.tokenize('10 grams of Sodium Chloride with 1g Apple, Mango(2kg) and Grapes 3kg; 1 litre water')
      
      expect(tokens[0]).to eq("10 grams")
      expect(tokens[1]).to eq(" ")
      expect(tokens[2]).to eq("of")
      expect(tokens[3]).to eq(" ")
      expect(tokens[4]).to eq("Sodium Chloride")
      expect(tokens[5]).to eq(" ")
      expect(tokens[6]).to eq("with")
      expect(tokens[7]).to eq(" ")
      expect(tokens[8]).to eq("1g Apple")
      expect(tokens[9]).to eq(",")
      expect(tokens[10]).to eq(" ")
      expect(tokens[11]).to eq("Mango")
      expect(tokens[12]).to eq("(")
      expect(tokens[13]).to eq("2kg")
      expect(tokens[14]).to eq(")")
      expect(tokens[15]).to eq(" ")
      expect(tokens[16]).to eq(" ")
      expect(tokens[17]).to eq("and")
      expect(tokens[18]).to eq(" ")
      expect(tokens[19]).to eq("Grapes 3kg")
      expect(tokens[20]).to eq(";")
      expect(tokens[21]).to eq(" ")
      expect(tokens[22]).to eq("1 litre water")
    end
  end

  context "More Practical Cases" do
    it "should tokenize the input with units properly" do
      
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

