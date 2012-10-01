module SessionsHelper

  def sign_in(storekeeper)
    cookies.permanent[:remember_token] = storekeeper.remember_token
    self.current_storekeeper = storekeeper
  end

  def current_storekeeper=(storekeeper)
    @current_storekeeper = storekeeper
  end

  def current_storekeeper
    @current_storekeeper ||= Storekeeper.find_by_remember_token(cookies[:remember_token])
  end

  def signed_in?
    !current_storekeeper.nil?
  end

  def sign_out
    self.current_storekeeper = nil
    cookies.delete(:remember_token)
  end

end
