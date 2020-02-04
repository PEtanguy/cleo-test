require_relative "base"
require_relative "../models/transactionlog"

class TransactionlogRepository < Base

  def build_element(row)
    row[:datetime]    = row[:datetime]
    row[:item_id] = row[:item_id].to_i
    row[:id] = row[:id].to_i
    row[:total_price] = row[:total_price].to_i
    row[:item_quantity] = row[:item_quantity].to_i
    Transactionlog.new(row)
  end

  def write_csv
    return if @elements.empty?

    CSV.open(@csv_file, "w") do |csv|
      csv << @elements.first.class.headers
      @elements.each do |element|
        csv << [element.id, element.item_quantity, element.total_price, element.item_id, element.datetime]
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      @elements << build_element(row)
      @next_id += 1
    end
  end
end
