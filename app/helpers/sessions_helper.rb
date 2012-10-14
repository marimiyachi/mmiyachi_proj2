module SessionsHelper

  # requires: storekeeper
  # creates a cookie for storekeeper and sets current_storekeeper variable
  def sign_in(storekeeper)
    cookies.permanent[:remember_token] = storekeeper.remember_token
    self.current_storekeeper = storekeeper
  end

  # current_storekeeper setter
  def current_storekeeper=(storekeeper)
    @current_storekeeper = storekeeper
  end

  # current_storekeeper getter
  def current_storekeeper
    @current_storekeeper ||= Storekeeper.find_by_remember_token(cookies[:remember_token])
  end

  # returns boolean true if input is the same as current_storekeeper
  def current_storekeeper?(user)
    user == current_storekeeper
  end

  # returns boolean true if user signed in
  def signed_in?
    !current_storekeeper.nil?
  end

  # signs out user and removes cookie
  def sign_out
    self.current_storekeeper = nil
    cookies.delete(:remember_token)
  end

  # redirects user to sign in
  def signed_in_user
    unless signed_in?
      redirect_to signin_url, notice: "Please sign in"
    end
  end

end
