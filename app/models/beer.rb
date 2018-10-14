class Beer < ApplicationRecord
  include RatingAverage
  include TopRated

  validates :name, presence: true
  validates :style, presence: true

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  def to_s
    brewery = Brewery.find brewery_id
    "#{name}, #{brewery.name}"
  end

  def self.top(n)
    Beer.all.sort_by{ |b| -(b.average_rating || 0) }.take(n)
  end
end
