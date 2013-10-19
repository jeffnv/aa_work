require 'spec_helper'

describe "the signup process" do 

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
  end

  describe "signing up a user" do
    before(:each) do
      sign_up("testing_username")
    end
    
    it "shows username on the homepage after signup" do
      expect(page).to have_content "testing_username"
    end
    
    it "should have logout button" do
      save_and_open_page
      expect(page).to have_button "Log Out"
    end
    
  end

end

describe "logging in" do 
  before(:all) do
    sign_up("another_test")
  end
  
  before(:each) do
    sign_in("another_test")
  end
  
  it "shows username on the homepage after login" do
    expect(page).to have_content "another_test"
  end
  
  it "should have logout button" do
    #save_and_open_page
    expect(page).to have_button "Log Out"
  end

end


describe "logging out" do 
  it "begins with logged out state" do
    visit new_session_url
    expect(page).to_not have_content "another_test"
  end
  
  it "doesn't show username on the homepage after logout" do
    sign_in("another_test")
    click_on("Log Out")
    expect(page).to_not have_content "another_test"
  end

end