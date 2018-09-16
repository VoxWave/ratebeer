class Brewery < ApplicationRecord
    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

    def average_rating
        self.ratings.average(:score)
    end

    def restart
        self.year = 2018
        puts "changed year to #{year}"
    end

end
