require_relative "base"
require_relative "../models/item"

class ItemRepository < Base

  def build_element(row)
    row[:id]    = row[:id].to_i
    row[:name] = row[:name].capitalize
    row[:price] = row[:price].to_f
    row[:quantity] = row[:quantity].to_i
    Item.new(row)
  end

  def write_csv
    return if @elements.empty?

    CSV.open(@csv_file, "w") do |csv|
      csv << @elements.first.class.headers
      @elements.each do |element|
        csv << [element.id, element.name.capitalize, element.price, element.quantity]
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
