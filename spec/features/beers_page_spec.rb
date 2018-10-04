require 'rails_helper'

describe "Beers page" do
  describe "creating a new beer" do
    before :each do
      @brewery = FactoryBot.create(:brewery)
      visit new_beer_path
    end
    it "beer can be added if the name is valid" do
      fill_in('beer_name', with: 'beer')
      expect {
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
      expect(Beer.first.name).to eq("beer")
    end

    it "beer cannot be added if the name is invalid and an error is outputted" do
      expect {
        click_button('Create Beer')
      }.not_to change{Beer.count}.from(0)
      expect(page).to have_content 'Name can\'t be blank'
    end
  end
end