require 'spec_helper'

describe Link do
  it "should have a valid factory" do
    FactoryGirl.build(:link).should be_valid
  end

  it "must have a title" do
    FactoryGirl.build(:link, :title => nil).should_not be_valid
  end

  it "must have a url" do
    FactoryGirl.build(:link, :url => nil).should_not be_valid
  end

  it "must have a submitter" do
    FactoryGirl.build(:link, :submitter_id => nil).should_not be_valid
  end

  it { should belong_to(:submitter) }

  it { should have_many(:subs) }

  it {should have_many(:comments)}
  it {should have_many(:votes)}

  it "has up/downvotes" do

    link = FactoryGirl.create(:link)

    4.times do
      link.votes << FactoryGirl.build(:user_vote)
    end

    link.upvotes.should equal(2)
    link.downvotes.should equal(2)
  end



end
