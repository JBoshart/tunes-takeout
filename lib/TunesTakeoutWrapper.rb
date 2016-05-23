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

  def self.find_by_id(suggestion_id)
    suggestion_data = HTTParty.get(BASE_URL + "/v1/suggestions/#{suggestion_id}")


    suggestion = self.new(suggestion_data["suggestion"])
    return suggestion
  end

  def self.top
    suggestion_data = HTTParty.get(BASE_URL + "/v1/suggestions/top?limit=20").parsed_response
    suggestions = []
    suggestion_data["suggestions"].each do |single|
      suggestions << HTTParty.get(BASE_URL + "/v1/suggestions/#{single}").parsed_response
    end

    pairing_info =[]
    suggestions.each do |single|
      pairing_info << self.new(single["suggestion"])
    end
    return pairing_info
  end

  def self.find_favorites(user_id)
    totes_faves = HTTParty.get(BASE_URL + "/v1/users/#{user_id}/favorites").parsed_response

    favorites = totes_faves["suggestions"]
    return favorites
  end

  def self.make_favorite(user_id, suggestion_id)
    @status = HTTParty.post(BASE_URL + "/v1/users/#{user_id}/favorites", body: { "suggestion": "#{suggestion_id}" }.to_json)
    return @status
  end

  def self.hate_favorite(user_id, suggestion_id)
    @status = HTTParty.delete(BASE_URL + "/v1/users/#{user_id}/favorites", body: { "suggestion": "#{suggestion_id}" }.to_json)
    return @status
  end
end
