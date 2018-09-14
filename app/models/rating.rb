class Rating < ApplicationRecord
    belongs_to :beer

    def to_s
        beer = Beer.find beer_id
        "#{beer.name} #{score}"
    end
end
