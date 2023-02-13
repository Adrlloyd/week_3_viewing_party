require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: "test123"
    fill_in :user_password_confirmation, with: "test123"
    click_button 'Create New User'

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("User One's Dashboard")
  end 

  it 'does not create a user if email isnt unique' do 
    User.create(name: 'User One', email: 'notunique@example.com', password: "test123")

    visit register_path
    
    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'notunique@example.com'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")    
  end

  it 'redircts back to register if name blank with error message' do
    visit register_path

    fill_in :user_name, with: ''
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: "test123"
    fill_in :user_password_confirmation, with: "test123"
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Name can't be blank")
  end

  it 'redircts back to register if email blank with error message' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:''
    fill_in :user_password, with: "test123"
    fill_in :user_password_confirmation, with: "test123"
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email can't be blank")
  end

  it 'redircts back to register if email blank with error message' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: "test123"
    fill_in :user_password_confirmation, with: ""
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
