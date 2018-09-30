require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password that is too short" do
    user = User.create username:"Pekka", password:"Se1", password_confirmation:"Se1"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password that only contains letters" do
    user = User.create username:"Pekka", password:"SecRetPassWord", password_confirmation:"SecRetPassWord"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user)}

    it "has a method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end
  
    it "without ratings a user does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating({user: user}, 10)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with the highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 10, 7, 5, 5, 20)
      best = create_beer_with_rating({user: user}, 25)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){ FactoryBot.create(:user) }

    it "has a method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings a user does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the style of the only rated if only one rating" do
      beer = create_beer_with_rating({user: user}, 10)
      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the same style as the group if all the beers have the same style" do
      create_beers_with_many_ratings({user: user}, 10, 20, 50, 2, 41)
      beer = create_beer_with_rating({user: user}, 7)
      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the style that has the highest average among beers" do
      create_beer_with_certain_style_and_rating({user: user}, 50, "the best")
      create_beers_with_certain_style_and_rating({user: user}, "the worst", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
      create_beers_with_certain_style_and_rating({user: user}, "decent", 20, 20, 20)
      expect(user.favorite_style).to eq("the best")
    end

  end


  describe "with a proper password" do
    let(:user){ FactoryBot.create(:user) }
    
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
end

def create_beer_with_rating(object, score)
  create_beer_with_certain_style_and_rating(object, score, "lager")
end

def create_beers_with_many_ratings(object, *scores)
  create_beers_with_certain_style_and_rating(object, "lager", *scores)
end

def create_beers_with_certain_style_and_rating (object, style, *scores)
  scores.each do |score|
    create_beer_with_certain_style_and_rating(object, score, style)
  end
end

def create_beer_with_certain_style_and_rating(object, score, style)
  beer = FactoryBot.create(:beer, style: style)
  FactoryBot.create(:rating, beer: beer, score: score, user: object[:user])
  beer
end