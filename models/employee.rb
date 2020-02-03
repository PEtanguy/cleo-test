class Employee
  attr_reader :email, :password, :role
  attr_accessor :id

  def initialize(properties = {})
    @email = properties[:email]
    @password = properties[:password]
    # @role = properties[:role]
    @id = properties[:id]
  end

  def to_csv_row
    [@id, @email, @password]
  end

  def self.headers
    %w[id email password]
  end
end
