require 'TunesTakeoutWrapper'
require 'Food'
require 'Music'

class SuggestionsController < ApplicationController

  def index
    # shows top 20 suggestions, ranked by total number of favorites
  end

  def show
    if params[:food_query]
      @food = TunesTakeoutWrapper.find(params[:food_query])
    else
      @music = TunesTakeoutWrapper.find(params[:music_query])
    end
    render partial: "suggestion"
  end

  def favorites
    # shows all suggestions favorited by the signed-in User
  end

  def favorite
    # adds a suggestion into the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
  end

  def unfavorite
    # removes a suggestion from the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
  end
end
