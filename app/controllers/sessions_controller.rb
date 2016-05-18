class SessionsController < ApplicationController
  def new
    # shows a view with OAuth sign-in link
  end

  def create
    # accepts OAuth information from Spotify, finds or creates a User account, and sets user_id in session
    auth_hash = request.env['omniauth.auth']
    if auth_hash[:info][:id]
      @user = User.find_or_create_from_omniauth(auth_hash)
      if @user
        session[:user_id] = @user.id
        redirect_to root_path
      else
        redirect_to root_path, notice: "Failed to save the user"
      end
    else
      redirect_to root_path, notice: "Failed to authenticate"
    end
  end


  def destroy
    # deletes user_id from session
    session.delete :user_id
    redirect_to root_path
  end
end
