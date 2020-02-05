class Transactionlog
  attr_reader :item_quantity, :total_price
  attr_accessor :id, :datetime, :item_id

  def initialize(properties = {})
    @datetime = Time.now
    @item_quantity = properties[:item_quantity]
    @total_price = properties[:total_price]
    @item_id = properties[:item_id]
    @id = properties[:id]
  end

  def to_csv_row
    [@id, @item_quantity, @total_price, @item_id, @datetime]
  end

  def self.headers
    %w[id item_quantity total_price item_id datetime]
  end
end
