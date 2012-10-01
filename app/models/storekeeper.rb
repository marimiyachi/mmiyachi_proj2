class Storekeeper < ActiveRecord::Base
  attr_accessible :email, :name, :password_digest

  has_many :stores
end
