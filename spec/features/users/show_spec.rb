require 'rails_helper'

RSpec.describe 'As a registered user' do
  before :each do
    @user = User.create!(name: "Jeremy", role: 0,
                      street_address: "1331 17th St",
                      city: "Denver",
                      state: "CO",
                      zip_code: 80202,
                      email_address: "Jeremy@test_user.com",
                      password: "password",
                      enabled: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  describe 'when I visit my own profile page' do
    it "I can see all my profile data except my password" do

      visit profile_path
      within "#profile-info" do
        expect(page).to have_content("Name: #{@user.name}")
        expect(page).to have_content("Street Address: #{@user.street_address}")
        expect(page).to have_content("City: #{@user.city}")
        expect(page).to have_content("State: #{@user.state}")
        expect(page).to have_content("Zip Code: #{@user.zip_code}")
        expect(page).to have_content("Email Address: #{@user.email_address}")
        expect(page).to_not have_content("#{@user.password}")
      end
      expect(page).to have_link("Edit my profile")
    end
  end
end
