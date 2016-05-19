require 'httparty'

class TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com"
  attr_reader :food, :music_id, :music_type

  def initialize(suggestion_data)
    @id = suggestion_data["suggestions"]["id"]
    @food = suggestion_data["suggestions"]["food"]
    @music_id = suggestion_data["suggestions"]["music_id"]
    @music_type = suggestion_data["suggestions"]["music_type"]
  end

  def self.find(search)
    suggestion_data = HTTParty.get(BASE_URL + "/v1/suggestions/search?query=#{search}")
    self.new(suggestion_data)
  end
end
