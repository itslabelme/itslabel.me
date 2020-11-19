require 'rails_helper'
require './spec/models/concerns/00_context.rb'

RSpec.describe Translation, type: :model do

  include_context 'dataset'

  context "Translate Paragraph" do
    it "should translate paragraph - simple cases" do
      expect(Translation.translate_paragraph('Sodium Chloride')).to eq('كلوريد الصوديوم')
      
      expect(Translation.translate_paragraph('10grams Mango')).to eq('مانجو جرامات 10')
      expect(Translation.translate_paragraph('Mango 10grams')).to eq('جرامات 10 مانجو')

      expect(Translation.translate_paragraph('10 grams Mango')).to eq('مانجو جرامات 10')
      expect(Translation.translate_paragraph('Mango 10 grams')).to eq('جرامات 10 مانجو')
    end

    it "should translate paragraph - combination words" do
      expect(Translation.translate_paragraph('10 grams of Sodium Chloride')).to eq('كلوريد الصوديوم من جرامات 10')
      expect(Translation.translate_paragraph('Buttermilk Powder (10%)', output_language: "FRENCH")).to eq('Poudre de papillon (10%)')
    end
  end

  context "More Practical Cases" do
    it "should translate for all practical cases" do

      # gm, grams and gms without round brackets
      expect(Translation.translate_paragraph('12.500gm Apple, 12.5gm Apple, 1g Apple.')).to eq('.تفاحة غ 1 ،تفاحة جم 12.5 ،تفاحة جم 12.500')
      expect(Translation.translate_paragraph('12.500grams Apple, 12.5grams Apple, 1gram Apple.')).to eq('.تفاحة غرام 1 ،تفاحة جرامات 12.5 ،تفاحة جرامات 12.500')
      expect(Translation.translate_paragraph('12.500gms Apple, 12.5gms Apple and 12gms Apple.')).to eq('.تفاحة جم 12 و تفاحة جم 12.5 ،تفاحة جم 12.500')

      expect(Translation.translate_paragraph('Apple 12.500 grams, Apple 12.5 grams and Apple 12 grams.')).to eq('.جرامات 12 تفاحة و جرامات 12.5 تفاحة ،جرامات 12.500 تفاحة')
      expect(Translation.translate_paragraph('Apple 12.500 gms, Apple 12.5 gms and Apple 12 gms.')).to eq('.جم تفاحة و جم تفاحة ،جم تفاحة')
      expect(Translation.translate_paragraph('Apple 12.500 gm, Apple 12.5 gm and Apple 12 g.')).to eq('.غ 12 تفاحة و جم تفاحة ،جم تفاحة')

      # gm, grams and gms with round brackets

      expect(Translation.translate_paragraph('Apple 12.500 grams, Apple 12.5 grams and Apple 12 grams.')).to eq('.جرامات 12 تفاحة و جرامات 12.5 تفاحة ،جرامات 12.500 تفاحة')
      expect(Translation.translate_paragraph('Apple 12.500 gms, Apple 12.5 gms and Apple 12 gms.')).to eq('.جم تفاحة و جم تفاحة ،جم تفاحة')
      expect(Translation.translate_paragraph('Apple 12.500 gm, Apple 12.5 gm and Apple 12 g.')).to eq('.غ 12 تفاحة و جم تفاحة ،جم تفاحة')

      expect(Translation.translate_paragraph('(12.500gm) Apple, (12.5gm) Apple, (1gm) Apple.')).to eq('')
      expect(Translation.translate_paragraph('(12.500grams) Apple, (12.5grams) Apple, (1gram) Apple.')).to eq('')
      expect(Translation.translate_paragraph('(12.500gms) Apple, (12.5gms) Apple and (12gms) Apple.')).to eq('')

      expect(Translation.translate_paragraph('(12.500 gm) Apple, (12.5 gm) Apple, (1 gm) Apple.')).to eq('')
      expect(Translation.translate_paragraph('(12.500 grams) Apple, (12.5 grams) Apple, (1 gram) Apple.')).to eq('')
      expect(Translation.translate_paragraph('(12.500 gms) Apple, (12.5 gms) Apple and (12 gms) Apple.')).to eq('')

      expect(Translation.translate_paragraph('Apple (12.500 grams), Apple (12.5 grams) and Apple (12 grams).')).to eq('')
      expect(Translation.translate_paragraph('Apple (12.500 gms), Apple (12.5 gms) and Apple (12 gms).')).to eq('')
      expect(Translation.translate_paragraph('Apple (12.500 gm), Apple (12.5 gm) and Apple (12 g).')).to eq('')

    end
  end

end

