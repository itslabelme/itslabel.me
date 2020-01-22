require 'spec_helper'

RSpec.describe ClientUser, type: :model do

  describe "Basic Tests" do
    context "Factory" do
      it "should validate all the factories" do
        expect(FactoryBot.build(:client_user).valid?).to be true
      end
    end

    context "Validations" do
      it { should validate_presence_of :first_name }
      it { should_not allow_value("x"*257).for(:first_name )}

      it { should allow_value(nil).for(:last_name )}
      it { should allow_value("").for(:last_name )}
      it { should_not allow_value("x"*257).for(:last_name )}

      it { should allow_value(nil).for(:mobile_number )}
      it { should allow_value("").for(:mobile_number )}
      it { should_not allow_value("x"*25).for(:mobile_number )}

      it { should allow_value(nil).for(:organisation )}
      it { should allow_value("").for(:organisation )}
      it { should_not allow_value("x"*257).for(:organisation )}

      it { should validate_presence_of :country }
      it { should allow_value("India").for(:country )}
      it { should_not allow_value("x"*257).for(:country )}
    end

  end

  context "Instance Methods" do
    it "should respond to generic methods" do
      client_user = FactoryBot.build(:client_user, first_name: "Tom", last_name: "Sawyer")
      expect(client_user.display_name).to eq("Tom Sawyer")
    end
  end

end