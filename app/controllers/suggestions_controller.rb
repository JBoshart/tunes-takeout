require 'TunesTakeoutWrapper'
require 'Music'
require 'Food'

class SuggestionsController < ApplicationController

  def index
    @favorites = TunesTakeoutWrapper.find_favorites(current_user.uid) if current_user

    top_twenty
  end

  def show
    if params[:find_food]
      suggestion = TunesTakeoutWrapper.find(params[:find_food])
    elsif params[:find_music]
      suggestion = TunesTakeoutWrapper.find(params[:find_music])
    end

    top_twenty
    search(suggestion)

    @search_result = arrayify(suggestion, @music, @food)
    @favorites = TunesTakeoutWrapper.find_favorites(current_user.uid) if current_user
    render partial: "suggestion"
  end

  def favorites
    if current_user
    @favorites = TunesTakeoutWrapper.find_favorites(current_user.uid)

    found_faves = []
    @favorites.each do |fave_id|
      found = TunesTakeoutWrapper.find_by_id(fave_id)
      found_faves << found
    end

    search(found_faves)

    @search_result = arrayify(found_faves, @music, @food)

    else
      @favorites = 1
    end

    render :favorites
  end

  def favorite
    @status = TunesTakeoutWrapper.make_favorite(current_user.uid, params[:pair_id])

    favorites
  end

  def unfavorite
    @status = TunesTakeoutWrapper.hate_favorite(current_user.uid, params[:pair_id])

    favorites
  end
end
