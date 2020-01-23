require 'spec_helper'

RSpec.describe AdminUser, type: :model do

  describe "Basic Tests" do
    context "Factory" do
      it "should validate all the factories" do
        expect(FactoryBot.build(:admin_user).valid?).to be true
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
    end

  end

  context "Instance Methods" do
    it "should respond to generic methods" do
      admin_user = FactoryBot.build(:admin_user, first_name: "Tom", last_name: "Sawyer")
      expect(admin_user.display_name).to eq("Tom Sawyer")
    end
  end

end