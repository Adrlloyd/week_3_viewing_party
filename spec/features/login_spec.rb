require 'rails_helper'

RSpec.describe 'Login_user' do
  before :each do 
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "test123")
    visit register_path

    fill_in :user_name, with: @user1.name
    fill_in :user_email, with: @user1.email
    fill_in :user_password, with: @user1.password
    fill_in :user_password_confirmation, with: @user1.password
    
    click_on "Create New User"

    visit login_path
  end

  it "has existing user login" do
    expect(current_path).to eq(login_path)
  
    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password
  
    click_on "Log In"
      
    expect(page).to have_content(@user1.name)
  end

  it "won't create user with mismatching passwords" do
    expect(current_path).to eq(login_path)
  
    fill_in :email, with: @user1.email
    fill_in :password, with: "wrong password"
  
    click_on "Log In"
    
    expect(current_path).to eq(login_path)
    expect(page).to have_content("Sorry your credentials are bad")
  end
end