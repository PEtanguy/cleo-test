class Transactionlog
  attr_reader :datetime, :quantity, :total_price
  attr_accessor :id, :datetime, :item_id

  def initialize(properties = {})
    @datetime = Time.now
    @quantity = properties[:quantity]
    @total_price = properties[:total_price]
    @item_id = properties[:item_id]
    @id = properties[:id]
  end

  def to_csv_row
    [@id, @quantity, @total_price, @item_id]
  end

  def self.headers
    %w[id quantity total_price item_id]
  end
end
