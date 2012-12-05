class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  # Authenticate users
  private
  # redirect if user is not logged in
  def signed_in_user
    redirect_to storekeepersignup_path, notice: "Please sign in." unless signed_in?
  end

  # redirect if user is accessing material they don't own
  def correct_user
    redirect_to root_path, notice: "Restricted access." unless current_storekeeper?(Storekeeper.find(params[:id]))
  end

end
