class Item
  attr_accessor :quantity, :id, :price, :name
  def initialize(attributes = {})

    @price = attributes[:price]
    @name = attributes[:name]
    @quantity = attributes[:quantity]
    @id = attributes[:id]

  end

  def reduce_inventory(amount_bought)
    @quantity -= amount_bought
  end

  def self.headers
    %w[id name price quantity]
  end
end
