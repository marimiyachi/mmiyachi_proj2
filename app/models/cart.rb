class Cart < ActiveRecord::Base
  attr_accessible :storekeeper_id

  belongs_to :storekeeper
  has_many :cart_items

  # requires: array of cart_items
  # returns: total of value of cart_items
  def total(cart_items)
    total = 0
    cart_items.each do |item|
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
    @order.update_attributes(customer_id: @customer, id: self.id, status: "Pending")
    self.cart_items.each do |item|
      @item = @order.order_its.new()
      @original = Item.find_by_id(item.item_number)
      if @original.quantity > 0
        @item.update_attributes(item_number: item.item_number,
                              price: @original.price,
                              name: @original.name,
                              status: "Pending",
                              store_id: @original.store_id)
        @original.update_quantity
      end
      item.destroy
    end
    return @order
  end

  # requires: item that is being added to the cart
  # creates new cart_item as mirror of original input item
  def add_item(item)
    new_item = self.storekeeper.carts.first.cart_items.build()
    new_item.update_attributes(item_number: item.id, store_number: item.store_id)
  end
end
