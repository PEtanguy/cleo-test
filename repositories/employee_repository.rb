require_relative "base"
require_relative "../models/employee"

class EmployeeRepository < Base
  def find_by_email(email)
    @elements.find { |element| element.email == email }
  end

  def build_element(row)
    row[:id] = row[:id].to_i
    row[:email] = row[:email]
    row[:password] = row[:password]
    Employee.new(row)
  end

  def write_csv
    return if @elements.empty?

    CSV.open(@csv_file, "w") do |csv|
      csv << @elements.first.class.headers
      @elements.each do |element|
        csv << [element.id, element.email, element.password]
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
