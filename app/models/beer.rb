class Beer < ApplicationRecord
    include RatingAverage
    belongs_to :brewery
    has_many :ratings, dependent: :destroy

    def to_s
        brewery = Brewery.find brewery_id
        "#{name}, #{brewery.name}"
    end
end
