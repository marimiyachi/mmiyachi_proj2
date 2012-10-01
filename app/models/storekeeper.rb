class Storekeeper < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  before_save { |storekeeper| storekeeper.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  vaildates :email, presence: true, format: {with: VALID_EMAIL }, uniqueness: { case_senstive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  has_many :stores
end
