class BeermappingApi
  def self.places_in(city)
    return [] if city.empty?

    city = city.downcase
    Rails.cache.fetch(city, expires_in: 2.minutes) {
      get_places_in(city)
    }
  end

  def self.get_places_in(city)
    return [] if city.empty?

    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) && places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do |place|
      Place.new(place)
    end
  end

  def self.place_by_id(id)
    Rails.cache.fetch(id, expires_in: 2.minutes) {
      get_place_by_id(id)
    }
  end

  def self.get_place_by_id(id)
    url = "http://beermapping.com/webservice/locquery/#{key}/#{id}"

    response = HTTParty.get url
    places = response.parsed_response["bmp_locations"]["location"]

    return nil if places.is_a?(Hash) && places['id'].nil?

    places = [places] if places.is_a?(Hash)
    Place.new(places.first)
  end

  def self.key
    raise "BEERMAPPING_APIKEY env variable not defined" if ENV['BEERMAPPING_APIKEY'].nil?

    ENV['BEERMAPPING_APIKEY']
  end
end
