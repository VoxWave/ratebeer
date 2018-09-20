class Brewery < ApplicationRecord
    include RatingAverage
    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

    def restart
        self.year = 2018
        puts "changed year to #{year}"
    end

end
