class SessionsController < ApplicationController

  def create
    storekeeper = Storekeeper.find_by_email(params[:session][:email].downcase)
    if storekeeper && storekeeper.authenticate(params[:session][:password])
      sign_in storekeeper
      redirect_to storekeeper
    else
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
