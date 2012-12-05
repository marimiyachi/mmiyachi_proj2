class Storekeeper < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  before_save { |storekeeper| storekeeper.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL }, uniqueness: { case_senstive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  has_many :stores
  has_many :cart_items
  has_many :orders
  has_many :saveds

  # returns a boolean true if a storekeeper has a store
  def store_exists
    return self.stores.count == 1
  end

  # requires: array of cart_items
  # returns: total of value of cart_items
  def total
    total = 0
    self.cart_items.each do |item|
      if item.quantity > 0
        if Item.find_by_id(item.item_number)
          item_price = Item.find_by_id(item.item_number).price
          total = total + item_price
        end
      end
    end
    return total
  end

  # requires: customer who is checking out cart
  # modifies: cart items, adding each to a new order belong to the customer
  #           deletes cart items from customer cart
  # returns: new order
  def final_checkout(customer)
    @order = customer.orders.new()
    @order.update_attributes(customer_id: customer.id, id: self.id, status: "Pending")
    self.cart_items.each do |item|
      @item = @order.order_its.new()
      @original = Item.find_by_id(item.item_number)
      if @original.quantity > 0
        @item.update_attributes(item_number: item.item_number,
                                price: @original.price,
                                name: @original.name,
                                status: "Pending",
                                store_id: @original.store_id)
        @original.decrement_quantity
      end
      item.destroy
    end
    return @order
  end

  # requires: item that is being added to the cart
  # creates new cart_item as mirror of original input item
  def add_item(item)
    new_item = self.cart_items.build()
    new_item.update_attributes(item_number: item.id, store_number: item.store_id)
  end


  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
