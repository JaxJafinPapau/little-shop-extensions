require 'rails_helper'

RSpec.describe 'When I visit our application I see a navbar' do
  before :each do
    @user = User.create(name: "Matt",
                      role: 0,
                      street_address: "1331 17th St",
                      city: "Denver",
                      state: "CO",
                      zip_code: 80202,
                      email_address: "MattW@test_user.com",
                      password: "test",
                      enabled: true)

    @merchant = User.create(name: "Merchant Matt",
                        role: 1,
                        street_address: "1331 17th St",
                        city: "Denver",
                        state: "CO",
                        zip_code: 80202,
                        email_address: "merchant_matt@test_user.com",
                        password: "merchant",
                        enabled: true)

    @admin = User.create(name: "Admin Matt",
                        role: 2,
                        street_address: "1331 17th St",
                        city: "Denver",
                        state: "CO",
                        zip_code: 80202,
                        email_address: "admin_matt@test_user.com",
                        password: "merchant",
                        enabled: true)
  end

#User Story 2
  describe 'As an unregistered user I see' do
    it 'has links to features available to unregistered users' do
      visit "/"
      within(".navbar") do
        expect(page).to have_link 'Home'
        click_link 'Home'
        expect(current_path).to eq(root_path)

        expect(page).to have_link 'All Items'
        click_link 'All Items'
        expect(current_path).to eq(items_path)

        expect(page).to have_link 'Merchants'
        click_link 'Merchants'
        expect(current_path).to eq(merchants_path)

        expect(page).to have_link 'My Cart'
        click_link 'My Cart'
        expect(current_path).to eq(cart_path)

        expect(page).to have_link 'Log In'
        click_link 'Log In'
        expect(current_path).to eq(login_path)

        expect(page).to have_link 'Register'
        click_link 'Register'
        expect(current_path).to eq(new_user_path)
      end
    end

    xit 'displays number of items in cart' do
      visit "/"
      #check within navbar for "0"
      visit "/items"
      #add item to cart
      #check navbar for content "1"
    end
  end

#User Story 3
  describe 'As a registered user I see' do

    it 'has all the above links except login and register and also has logout and profile links' do
      visit root_path
      within(".navbar") do

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        expect(page).to have_link 'Home'
        expect(current_path).to eq(root_path)

        expect(page).to have_link 'All Items'
        click_link 'All Items'
        expect(current_path).to eq(items_path)

        expect(page).to have_link 'Merchants'
        click_link 'Merchants'
        expect(current_path).to eq(merchants_path)

        expect(page).to have_link 'My Cart'
        click_link 'My Cart'
        expect(current_path).to eq(cart_path)

        expect(page).to have_link 'Profile'
        click_link 'Profile'
        expect(current_path).to eq(profile_path)

        expect(page).to have_link 'Log Out'

        expect(page).to_not have_link 'Log In'
        expect(page).to_not have_link 'Register'
      end
    end

    it 'displays the user name' do
      visit root_path
      within(".navbar") do

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        visit root_path
        expect(page).to have_content 'Logged in as Matt'
      end
    end
  end


#User Story 4
  describe 'As a merchant user I see' do

      it 'has all the above links except login and register or shopping cart' do
        visit root_path
        within(".navbar") do
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

          expect(page).to have_link 'Home'
          expect(current_path).to eq(root_path)

          expect(page).to have_link 'All Items'
          click_link 'All Items'
          expect(current_path).to eq(items_path)

          expect(page).to have_link 'Merchants'
          click_link 'Merchants'
          expect(current_path).to eq(merchants_path)

          expect(page).to have_link 'Log Out'

          expect(page).to have_link 'Dashboard'
          click_link 'Dashboard'
          expect(current_path).to eq(dashboard_path)

          expect(page).to_not have_link 'My Cart'
          expect(page).to_not have_link 'Log In'
          expect(page).to_not have_link 'Register'
      end
    end
  end

#User Story 5
  describe 'As an admin I see' do

      it 'has all the above links except login and register or shopping cart' do
        visit root_path
        within(".navbar") do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

        expect(page).to have_link 'Home'
        expect(current_path).to eq(root_path)

        expect(page).to have_link 'All Items'
        click_link 'All Items'
        expect(current_path).to eq(items_path)

        expect(page).to have_link 'Merchants'
        click_link 'Merchants'
        expect(current_path).to eq(merchants_path)

        expect(page).to have_link 'Dashboard'
        click_link 'Dashboard'
        expect(current_path).to eq(admin_dashboard_path)

        expect(page).to have_link 'Log Out'

        expect(page).to_not have_link 'My Cart'
        expect(page).to_not have_link 'Log In'
        expect(page).to_not have_link 'Register'
      end
    end
  end

#User Story 6
  # describe 'it has access protections in place' do
  #   it 'keeps visitors away from user, merchant, and admin routes' do
  #     visit dashboard_path
  #     expect(page.status_code).to eq(404)
  #     visit admin_dashboard_path
  #     expect(page.status_code).to eq(404)
  #
  #   end
  # end


end
