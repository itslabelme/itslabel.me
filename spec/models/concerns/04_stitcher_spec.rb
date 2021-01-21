require 'rails_helper'
require './spec/models/concerns/00_context.rb'

RSpec.describe Translation, type: :model do

  include_context 'dataset'

  context "Stitcher" do
    it "should stitch scores back" do
      scores = { "10"=>{:score=>nil},
                 "grams"=>{:score=>0, :translation=>"جرامات"},
                 "of"=>{:score=>0, :translation=>"من"},
                 "SodiumChloride"=>{:score=>0, :translation=>"كلوريد الصوديوم"}
               }
      expect(Translation.stitch_token(scores)).to eq('كلوريد الصوديوم من جرامات 10')
    end
  end

  context "More Practical Cases" do
    it "should stitch all practical cases" do

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

