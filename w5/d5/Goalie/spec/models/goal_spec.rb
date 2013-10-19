require 'spec_helper'

describe Goal do
  
  describe "Valid Factory" do
    it "should build a valid factory" do
      FactoryGirl.build(:goal).should be_valid
    end
  end
  
  describe "Assosciations" do
    it { should belong_to(:user) }
  end
  
  describe "Validations" do
    it "should not allow empty goal info" do
      FactoryGirl.build(:goal, goal_info: nil).should_not be_valid
    end
    
    it "should allow status to default to Not Started" do
      expect(FactoryGirl.create(:goal).status == "Not Started").to be_true
    end
    
    it "should default visibility to public" do
      expect(FactoryGirl.create(:goal).visibility == "Public").to be_true
    end
    
    it "should not allow user_id to be nil" do
      FactoryGirl.build(:goal, user_id: nil).should_not be_valid
    end
    
    it "should enforce inclusion in approved options for status" do
      FactoryGirl.build(:goal, status: "bananas").should_not be_valid
    end
    
    it "should enforce inclusion in approved options for visibility" do
      FactoryGirl.build(:goal, visibility: "bananas").should_not be_valid
    end
  end
  
  describe "Mass Assignability" do
    it { should allow_mass_assignment_of(:user_id) }
    it { should allow_mass_assignment_of(:goal_info) }
    it { should allow_mass_assignment_of(:status) } 
    it { should allow_mass_assignment_of(:visibility) }
  end
  
  describe "Methods" do
    
  end
end
