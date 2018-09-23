class User < ApplicationRecord
  include RatingAverage

  has_secure_password
  validates :password, length: { minimum: 4 },
                       format: { with: /(\d.*[A-Z])|([A-Z].*\d)/ }
                      
  validates :username, uniqueness: true,
                       length: { minimum: 3,
                                 maximum: 30}
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
end
