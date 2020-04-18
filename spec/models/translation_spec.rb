require 'spec_helper'

RSpec.describe Translation, type: :model do

  describe "Basic Tests" do
    context "Factory" do
      it "should validate all the factories" do
        expect(FactoryBot.build(:english_to_arabic_translation).valid?).to be true
        expect(FactoryBot.build(:english_to_french_translation).valid?).to be true
      end
      it "should validate all the factories with traits" do
        expect(FactoryBot.build(:english_to_arabic_translation, :approved).valid?).to be true
        expect(FactoryBot.build(:english_to_arabic_translation, :approved, :with_admin_user).valid?).to be true
        expect(FactoryBot.build(:english_to_arabic_translation, :pending, :with_admin_user).valid?).to be true

        expect(FactoryBot.build(:english_to_french_translation, :approved).valid?).to be true
        expect(FactoryBot.build(:english_to_french_translation, :approved, :with_admin_user).valid?).to be true
        expect(FactoryBot.build(:english_to_french_translation, :pending, :with_admin_user).valid?).to be true
      end
    end

    context "Validations" do
      it { should validate_presence_of :english_phrase }
      it { should_not allow_value("x"*257).for(:english_phrase )}

      it { should validate_presence_of :arabic_phrase }
      it { should_not allow_value("x"*257).for(:arabic_phrase )}

      it { should validate_presence_of :french_phrase }
      it { should_not allow_value("x"*257).for(:french_phrase )}

      # it { should validate_presence_of :input_language }
      # it { should_not allow_value("x"*257).for(:input_language )}

      # it { should validate_presence_of :output_language }
      # it { should_not allow_value("x"*257).for(:output_language )}

      it { should validate_presence_of :status }
      it { should validate_inclusion_of(:status).in_array(Translation::STATUS_LIST.keys).with_message(/is not a valid status/) }

    end

  end

  context "Instance Methods" do
    it "should respond to generic methods" do
      translation = FactoryBot.build(:english_to_arabic_translation, english_phrase: "Apple", arabic_phrase: "Mango")
      expect(translation.display_name).to eq("Apple - Mango")
    end
  end

end