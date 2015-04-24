require 'rails_helper'

RSpec.feature "Campaigns", type: :feature do
  let(:user) { create(:user) }

  describe "Home Page" do

    it "displays a welcome message" do
      visit root_path
      expect(page).to have_text "Welcome to Fund.sy"
    end

    it "displays title" do
      visit root_path
      expect(page).to have_title "Fund.sy - Crowdfunding for the awesome"
    end

    context "with campaigns created" do
      let!(:campaign) { create(:campaign) }
      let!(:campaign_1) { create(:campaign) }

      it "displays the title of the campaign" do
        visit root_path
        # regex, i is for case insensitive
        expect(page).to have_text /#{campaign.title}/i
      end

      it "displays campaign title in h2 elements" do
        visit root_path
        expect(page).to have_selector("h2", /#{campaign.title}/i)
      end
    end
  end

  describe "Creating Campaign" do

    it "creates  campaign, redirects to show page and displays message" do
      login_via_web(user)

      visit new_campaign_path

      valid_attributes = attributes_for(:campaign)

      fill_in "Title", with: valid_attributes[:title]
      fill_in "Description", with: valid_attributes[:description]
      fill_in "Goal", with: valid_attributes[:goal]
      click_button "Create Campaign"

      expect(Campaign.count).to eq(1)
      expect(current_path).to eq(campaign_path(Campaign.last))
      expect(page).to have_content /Campaign Created/i

    end
  end

end
