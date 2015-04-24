require 'rails_helper'

RSpec.feature "Users", type: :feature do
  describe "Creating User account" do

    it "creates a user in the database with valid attributes" do
      valid_attributes = attributes_for(:user)
      visit new_user_path

      # when
      fill_in "First name", with: valid_attributes[:first_name]
      fill_in "Last name", with: valid_attributes[:last_name]
      fill_in "Email", with: valid_attributes[:email]
      fill_in "Password", with: valid_attributes[:password]
      fill_in "Password confirmation", with: valid_attributes[:password]
      click_button "Create Account"

      # then
      expect(User.count).to eq(1)
      expect(current_path).to eq(root_path)

      # save_and_open_page
    end

  end
end
