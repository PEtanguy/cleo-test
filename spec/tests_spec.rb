require_relative "../models/item"
require_relative "../models/employee"
require_relative "../controllers/machines_controller.rb"
require_relative "../controllers/sessions_controller.rb"
require_relative "../repositories/employee_repository.rb"
require_relative "../repositories/transactionlog_repository.rb"
require_relative "../repositories/item_repository.rb"
require_relative "support/csv_helper"




describe "ItemRepository", :item_repository do
  let(:csv_path) { "spec/support/item_repository.csv" }
  let(:repository) { ItemRepository.new(csv_path) }
  let(:items) do
    [
      [ "id", "name", "price", "quantity" ],
      [ 1, "Cheetos", 350, 7 ],
      [ 2, "Hersheys", 200, 7 ],
    ]
  end
  before(:each) do
    CsvHelper.write_csv(csv_path, items)
  end

  def elements(repo)
    repo.instance_variable_get(:@items) ||
      repo.instance_variable_get(:@elements)
  end

  describe "#initialize" do
    it "should take one argument: the CSV file path to store meals" do
      expect(ItemRepository.instance_method(:initialize).arity).to eq(1)
    end

    it "should not crash if the CSV path does not exist yet." do
      expect { ItemRepository.new('unexisting_file.csv') }.not_to raise_error
    end

    it "store items in memory in an instance variable `@items` or `@elements`" do
      repo = ItemRepository.new(csv_path)
      expect(elements(repo)).to be_a(Array)
    end

    # it "loads existing items from the CSV" do
    #   repo = ItemRepository.new(csv_path)
    #   loaded_items = elements(repo) || []
    #   expect(loaded_items.length).to eq(5)
    # end

    it "fills the `@items` with instance of `Meal`, setting the correct types on each property" do
      repo = ItemRepository.new(csv_path)
      loaded_items = elements(repo) || []
      fail if loaded_items.empty?
      loaded_items.each do |item|
        expect(item).to be_a(Item)
        expect(item.id).to be_a(Integer)
        expect(item.price).to be_a(Integer)
        expect(item.quantity).to be_a(Integer)
      end
    end
  end

end


describe "Item", :item do
  it "should be initialized with a hash of properties" do
    properties = { id: 1, name: "Cheetos", price: 200 }
    item = Item.new(properties)
    expect(item).to be_a(Item)
  end

  describe "#id" do
    it "should return the item id" do
      item = Item.new({ id: 42 })
      expect(item.id).to eq(42)
    end
  end

  describe "#id=" do
    it "should set the item id" do
      item = Item.new({ id: 42 })
      item.id = 43
      expect(item.id).to eq(43)
    end
  end

  describe "#name" do
    it "should return the name of the item" do
      item = Item.new({ name: "Cheetos" })
      expect(item.name).to eq("Cheetos")
    end
  end

  describe "#price" do
    it "should return the price of the item" do
      item = Item.new({ price: 200 })
      expect(item.price).to eq(200)
    end
  end
end


describe "EmployeeRepository", :employee do
  let(:employees) do
    [
      [ "id", "email", "password" ],
      [ 1, "pierre@cleo.com", "secret"]
    ]
  end
  let(:csv_path) { "spec/support/employees.csv" }

  before(:each) do
    CsvHelper.write_csv(csv_path, employees)
  end

  def elements(repo)
    repo.instance_variable_get(:@employees) ||
      repo.instance_variable_get(:@elements)
  end

  describe "#initialize" do
    it "should take one argument: the CSV file path to store employees" do
      expect(EmployeeRepository.instance_method(:initialize).arity).to eq(1)
    end

    it "should not crash if the CSV path does not exist yet." do
      expect { EmployeeRepository.new('unexisting_file.csv') }.not_to raise_error
    end

    it "should store employees in memory in an instance variable `@employees` or `@elements`" do
      repo = EmployeeRepository.new(csv_path)
      expect(elements(repo)).to be_a(Array)
    end

    it "should load existing employees from the CSV" do
      repo = EmployeeRepository.new(csv_path)
      loaded_employees = elements(repo) || []
      expect(loaded_employees.length).to eq(1)
    end

    it "fills the `@employees` with instance of `Employee`, setting the correct types on each property" do
      repo = EmployeeRepository.new(csv_path)
      loaded_employees = elements(repo) || []
      fail if loaded_employees.empty?
      loaded_employees.each do |employee|
        expect(employee).to be_a(Employee)
        expect(employee.id).to be_a(Integer)
        expect(employee.email).not_to be_empty
        expect(employee.password).not_to be_empty
      end
    end
  end

  describe "#all" do
    it "should return all the employees stored by the repo" do
      repo = EmployeeRepository.new(csv_path)
      expect(repo.all).to be_a(Array)
      expect(repo.all.size).to eq(1)
      expect(repo.all[0].email).to eq("pierre@cleo.com")
    end

    it "EmployeeRepository should not expose the @employees through a reader/method" do
      repo = EmployeeRepository.new(csv_path)
      expect(repo).not_to respond_to(:employees)
    end
  end

  describe "#find_by_email" do
    it "should retrieve a specific employee based on its email" do
      repo = EmployeeRepository.new(csv_path)
      employee = repo.find_by_email("pierre@cleo.com")
      expect(employee).not_to be_nil
      expect(employee.id).to eq(1)
      expect(employee.email).to eq("pierre@cleo.com")
    end
  end
end

describe "SessionsController", :session do
  let(:employee) do
    [
      [ "id", "email", "password" ],
      [ 1, "pierre@cleo.com", "secret"]
    ]
  end
  let(:csv_path) { "spec/support/employee_repository.csv" }
  let(:repository) { EmployeeRepository.new(csv_path) }
  properties = { id: 1, email: "pierre@cleo.com", password: 'secret'}

  before(:each) do
    CsvHelper.write_csv(csv_path, employee)
  end

  it 'returns the correct employee' do
    expect(repository.find_by_email("pierre@cleo.com")).to be_a(Employee)
  end

  # context 'password is valid' do
  #   expect()
  # end

  # context 'password is invalid' do
  #   it 'xxx' do
  #   end
  # end

end