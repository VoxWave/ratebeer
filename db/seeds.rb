# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
weizen = Style.create name:"Weizen"
lager = Style.create name:"Lager"
pale_ale = Style.create name:"Pale Ale"
ipa = Style.create name:"IPA"
porter = Style.create name:"Porter"

b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1040

b1.beers.create name:"Iso 3", style:lager
b1.beers.create name:"Karhu", style:lager
b1.beers.create name:"Tuplahumala", style:lager
b2.beers.create name:"Huvila Pale Ale", style:pale_ale
b2.beers.create name:"X Porter", style:porter
b3.beers.create name:"Hefeweizen", style:weizen
b3.beers.create name:"Helles", style:lager