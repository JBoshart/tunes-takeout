require 'TunesTakeoutWrapper'
require 'RSpotify'

class Music < ActiveRecord::Base

  attr_reader :id, :uri, :type, :title, :artist, :image_url

  def initialize(suggestion_data)
    @id = suggestion_data.id
    @uri = suggestion_data.uri
    @type = suggestion_data.type
    @title = suggestion_data.name
    @artist = suggestion_data.artists[0].name unless suggestion_data.type == "artist"
    if suggestion_data.type == "album" || suggestion_data.type == "artist"
      @image_url = suggestion_data.images.first["url"] unless !suggestion_data.images.nil?
    end
  end

  def self.find(suggestion_data)
    if suggestion_data.music_type == "track"
      data = RSpotify::Track.find(suggestion_data.music_id)
    elsif suggestion_data.music_type == "album"
      data = RSpotify::Album.find(suggestion_data.music_id)
    elsif suggestion_data.music_type == "artist"
      data = RSpotify::Artist.find(suggestion_data.music_id)
    end

    self.new(data)
  end
end
