require 'spec_helper'

describe Sub do
  it "should have a valid factory" do
    FactoryGirl.build(:sub).should be_valid
  end

  it "must have a name" do
    FactoryGirl.build(:sub, :name => nil).should_not be_valid
  end

  it "must have a moderator_id" do
    FactoryGirl.build(:sub, :moderator_id => nil).should_not be_valid
  end

  it { should belong_to :moderator }
  it { should have_many :links }
end
