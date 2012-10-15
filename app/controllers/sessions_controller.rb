class SessionsController < ApplicationController

  # Creates a session for Storekeeper user
  # Matches to password to authenticate and then redirect
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
  def destroy
    sign_out
    redirect_to root_url
  end

end
