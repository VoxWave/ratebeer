class User < ApplicationRecord
  include RatingAverage

  has_secure_password
  validates :password, length: { minimum: 4 },
                       format: { with: /(\d.*[A-Z])|([A-Z].*\d)/ }

  validates :username, uniqueness: true,
                       length: { minimum: 3,
                                 maximum: 30 }
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    ratings.max_by{ |r| average_score_of_style(r.beer.style) }.beer.style
  end

  def average_score_of_style(style)
    ratings_of_style = ratings.select{ |r| r.beer.style == style }
    ratings_of_style.map(&:score).sum / ratings_of_style.length.to_f
  end

  def self.top(n)
    User.all.sort_by{ |user| user.ratings.length }.take(n)
  end

  def to_s
    username
  end
end
