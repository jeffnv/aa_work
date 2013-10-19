require 'spec_helper'

describe "Goals" do
  before(:each) do 
    sign_up("test_user")
  end
  
  it "has an add goal page" do
    visit new_goal_url
    expect(page).to have_content("New goal")
  end
  
  describe "ADD a goal" do
    before(:each) do
      click_link("New goal")
    end
    
    it "should add a goal, and then display that goal on the index" do
      add_goal(:goal_info => "test")
      expect(page).to have_content("test")
    end
  end
  
  describe "SHOW a goal" do
    before(:each) do
      add_goal(goal_info: "test goal")
      save_and_open_page
      click_link("test goal")
    end
    
    describe "Edit a Goal" do 
      it "should have an edit button" do
        
        expect(page).to have_link("Edit Goal")
      end
      
      it "should save changes" do
        click_link("Edit Goal")
        #edit form
        fill_in "Goal Name", with: "Test Goal EDITED"
        select "In Progress", from: 'Status'
        click_link("Edit Goal!")
        #back to show page
        expect(page).to have_content("Test Goal EDITED")
        expect(page).to have_content("In Progress")
      end
    end
    
    describe "Complete a Goal" do
      it "should have a complete button" do
        expect(page).to have_button("Complete!")
      end
      
      it "should not show the goal on the index after completion" do
        click button("Complete!")
        expect(page).to_not have_content("test goal")
      end
    end
    
    describe "Delete a Goal" do
      it "should have a delete button" do
        expect(page).to have_button("Delete!")
      end
      
      it "should not show the goal on index after deletion" do
        click button("Delete!")
        expect(page).to_not have_content("test goal")
      end
    end
  end
  
  describe "Goal Index" do
    it "should link to add goal page"
    
    it "should link to a goal's show page"

    it "should not show other peoples private goals"
  
    it "should show your private and public goals"
  end
end