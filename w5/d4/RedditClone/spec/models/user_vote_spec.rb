require 'spec_helper'

describe UserVote do
  it "should have a valid factory" do
    FactoryGirl.build(:user_vote).should be_valid
  end

  it "must have a link_id" do
    FactoryGirl.build(:user_vote, :link_id => nil).should_not be_valid
  end

  it "must have a voter_id" do
    FactoryGirl.build(:user_vote, :voter_id => nil).should_not be_valid
  end

  it "must have a vote" do
    FactoryGirl.build(:user_vote, :vote => nil).should_not be_valid
  end

  it "should only allow 1 vote on 1 link per user" do
    FactoryGirl.create(:user_vote, :voter_id => 1)
    FactoryGirl.build(:user_vote, :voter_id => 1).should_not be_valid
  end

  it { should belong_to :link }

  it { should belong_to :voter }



end
