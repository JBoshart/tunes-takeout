class Music < ActiveRecord::Base

  attr_reader :item_id, :type, :name, :url, :image_url

  def initialize(suggestion_data)
    @item_id = suggestion_data["item_id"]
    @type = suggestion_data["type"]
    @name = suggestion_data["name"]
    @url = suggestion_data["url"]
    @image_url = suggestion_data["image_url"]
  end

  def self.find(suggestion_data)
    if music_type == "track"
      suggestion_data = RSpotify::Track.find(music_id) #sometimes quotes work here, sometimes they dont....
    elsif music_type == "album"
      suggestion_data = RSpotify::Album.find(music_id)
    elsif music_type == "artist"
      suggestion_data = RSpotify::Artist.find(music_id)
    end
    self.new(suggestion_data)
  end
end
