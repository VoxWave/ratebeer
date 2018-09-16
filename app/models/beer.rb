class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings, dependent: :destroy

    def average_rating
        self.ratings.average(:score)
    end

    def to_s
        brewery = Brewery.find brewery_id
        "#{name}, #{brewery.name}"
    end
end
