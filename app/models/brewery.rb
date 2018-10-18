class Brewery < ApplicationRecord
  include RatingAverage
  include TopRated

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1040,
                                   only_integer: true }
  validate :not_in_future

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def not_in_future
    if year > Time.now.year
      errors.add(:year, "can't be in the future")
    end
  end

  def restart
    self.year = 2018
    puts "changed year to #{year}"
  end

  def to_s
    "#{name}, established in #{year}"
  end
end
