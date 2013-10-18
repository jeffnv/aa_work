require 'spec_helper'

describe LinkSub do
  it "should have a valid factory" do
    FactoryGirl.build(:link_sub).should be_valid
  end

  it "must have a link_id" do
    FactoryGirl.build(:link_sub, :link_id => nil).should_not be_valid
  end

  it "must have a sub_id" do
    FactoryGirl.build(:link_sub, :sub_id => nil).should_not be_valid
  end

  it { should belong_to :link }

  it { should belong_to :sub }

end
