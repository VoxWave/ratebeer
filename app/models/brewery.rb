class Brewery < ApplicationRecord
    has_many :beers

    def restart
        self.year = 2018
        puts "changed year to #{year}"
    end

end
