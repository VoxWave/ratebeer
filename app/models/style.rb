class Style < ApplicationRecord
  include RatingAverage
  include TopRated

  has_many :beers
  has_many :ratings, through: :beers

  def to_s
    name
  end
end
