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

    def self.find(tune_pairs)
      music = []
      tune_pairs.each do |music_item|

        if music_item.music_type == "track"
          item_found = RSpotify::Track.find(music_item.music_id)
        elsif music_item.music_type == "album"
          item_found = RSpotify::Album.find(music_item.music_id)
        elsif music_item.music_type == "artist"
          item_found = RSpotify::Artist.find(music_item.music_id)
        end

        music << self.new(item_found)
      end
    return music
    end
  end
