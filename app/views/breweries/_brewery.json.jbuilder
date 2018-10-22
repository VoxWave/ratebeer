json.extract! brewery, :id, :name, :year
json.beeramount brewery.beers.length
if brewery.active
  json.status 'active'
else
  json.status 'inactive'
end
