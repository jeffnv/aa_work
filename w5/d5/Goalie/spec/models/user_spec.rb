require 'spec_helper'

describe User do
  describe "Check if Factory works" do
    it "should check if Factory works" do
      FactoryGirl.build(:user).should be_valid
    end
  end
  
  describe "Validations" do
    it "should not accept nil username" do
      FactoryGirl.build(:user, username: nil).should_not be_valid
    end
    it "should not accept empty username" do
      FactoryGirl.build(:user, username: "").should_not be_valid
    end
    it "should not accept duplicate usernames" do
      FactoryGirl.create(:user)
      FactoryGirl.build(:user).should_not be_valid
    end
    it "should not accept a password < 6 letters" do
      FactoryGirl.build(:user, password: "apple").should_not be_valid
    end
  end
  describe "Mass Assignability" do
    it { should allow_mass_assignment_of(:username) }
    it { should_not allow_mass_assignment_of(:session_token) }
    it { should_not allow_mass_assignment_of(:password_digest) }
    it { should allow_mass_assignment_of(:password) }
  end
  
  describe "Assosciations" do
  end
  
  describe "Methods" do
    describe "#password=" do
      it "should set password_digest" do
        FactoryGirl.build(:user).password_digest.should_not be_nil
      end
    end
    
    describe "is_password?(password)" do
      it "should correctly verify password" do
        FactoryGirl.build(:user).is_password?("asdfasdf").should be_true
      end
    end
    
    describe "::find_by_credentials(username, password)" do
      it "should find the user by credentials" do
        FactoryGirl.create(:user)
        user = User.find_by_credentials(username: "Jaydeep", password: "asdfasdf")
        user.should_not be_nil
      end
    end
    
    describe "#ensure_session_token" do
      it "should ensure presence of session token" do
        user = FactoryGirl.build(:user)
        user.session_token = nil
        user.should be_valid
      end
    end
    
    describe "#reset_session_token" do
      it "should reset the session token" do
        user = FactoryGirl.build(:user)
        old_token = user.session_token
        new_token = user.reset_session_token!
        expect(new_token == old_token).to be_false
      end
    end
  end
end
