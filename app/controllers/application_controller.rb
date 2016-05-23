class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :top_twenty, :arrayify

  def top_twenty
    top = TunesTakeoutWrapper.top
    search(top)
    @pairs = arrayify(top, @music, @food)
  end

  def search(pair)
    @music = Music.find(pair)
    @food = Food.find(pair)
    return @music, @food
  end

  def arrayify(thing_1, thing_2, thing_3)
    pairs = []
    index = 0

    until index == thing_1.length
      pair = []
      pair << thing_1[index]
      pair << thing_2[index]
      pair << thing_3[index]
      pairs << pair
      index += 1
    end
    return pairs
  end

  def current_user
    @user ||= User.find_by(id: session[:user_id])
  end
end
