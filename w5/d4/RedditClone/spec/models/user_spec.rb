require 'spec_helper'

describe User do
  it "should have a valid factory" do
    FactoryGirl.build(:user).should be_valid
  end

  it "must have a username" do
    FactoryGirl.build(:user, :username => nil).should_not be_valid
  end

  it "must have a password" do
    FactoryGirl.build(:user, :password => nil).should_not be_valid
  end

  it "should ensure a session_token is present before saving" do
    FactoryGirl.create(:user).should_not be_nil
  end

  it { should_not allow_mass_assignment_of(:password_digest) }

  it { should_not allow_mass_assignment_of(:session_token) }

  it "should have a unique username" do
     FactoryGirl.create(:user)

     FactoryGirl.build(:user).should_not be_valid
  end

  it { should have_many :subs }
  it { should have_many :submitted_links }
  it { should have_many :comments }

  it "should have a find_by_credentials method" do
    FactoryGirl.create(:user, password: "password", username: "tester")
    User.find_by_credentials(username: 'tester', password: "password").should_not be_nil
  end

end
