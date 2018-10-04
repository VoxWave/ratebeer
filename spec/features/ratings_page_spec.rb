require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryBot.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }
  describe "when creating a rating" do
    before :each do
      sign_in(username:"Pekka", password:"Foobar1")
    end

    it "when given, is registered to the beer and user who is signed in" do
      visit new_rating_path
      select('iso 3', from:'rating[beer_id]')
      fill_in('rating[score]', with:'15')

      expect{
        click_button "Create Rating"
      }.to change{Rating.count}.from(0).to(1)

      expect(user.ratings.count).to eq(1)
      expect(beer1.ratings.count).to eq(1)
      expect(beer1.average_rating).to eq(15.0)
    end
  end
  describe "ratings page" do
    before :each do
      @scores = [1,2,3,4,5]
      @scores.each do |score|
        FactoryBot.create :rating, score: score, user: user
      end
      visit ratings_path
    end
    it "lists all ratings and ratings amount" do
      expect(page).to have_content "Number of ratings: #{@scores.length}"
      @scores.each do |score|
        expect(page).to have_content "anonymous #{score} Pekka"
      end
    end
  end
end