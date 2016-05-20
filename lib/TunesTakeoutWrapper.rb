require 'httparty'

class TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com"
  attr_reader :id, :food_id, :music_id, :music_type

  def initialize(suggestion_data)
    @id = suggestion_data["id"]
    @food_id = suggestion_data["food_id"]
    @music_id = suggestion_data["music_id"]
    @music_type = suggestion_data["music_type"]
  end

  def self.find(search)
    suggestion_data = HTTParty.get(BASE_URL + "/v1/suggestions/search?query=#{search}")
    suggestions = []
    suggestion_data["suggestions"].each do |single|
      suggestions << self.new(single)
    end
    return suggestions
  end
end
