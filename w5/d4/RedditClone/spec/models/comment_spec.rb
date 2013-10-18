require 'spec_helper'

describe Comment do
  it "should have a valid factory" do
    FactoryGirl.build(:comment).should be_valid
  end

  it "must have a body" do
    FactoryGirl.build(:comment, :body => nil).should_not be_valid
  end

  it "must have a link_id" do
    FactoryGirl.build(:comment, :link_id => nil).should_not be_valid
  end

  it "must have an author_id" do
    FactoryGirl.build(:comment, :author_id => nil).should_not be_valid
  end

  it { should belong_to(:link) }

  it { should belong_to(:parent_comment) }

  it { should belong_to(:author) }

  it { should have_many(:child_comments) }


end
