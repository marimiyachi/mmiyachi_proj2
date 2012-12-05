class SessionsController < ApplicationController

  # Creates a session for Storekeeper user
  # Matches to password to authenticate and then redirect

  # Requires: valid email and password
  # Modifies: sessions
  # Effects: creates a new session for the user and redirects to the user profile
  def create
    storekeeper = Storekeeper.find_by_email(params[:session][:email].downcase)
    if storekeeper && storekeeper.authenticate(params[:session][:password])
      sign_in storekeeper
      redirect_to storekeeper
    else
      render 'new'
    end
  end

  # Sign out of session

  # Requires: user logged in
  # Modifies: sessions
  # Effects: destroys user session and redirects to home
  def destroy
    sign_out
    redirect_to root_url
  end

end
