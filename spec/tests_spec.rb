require_relative "../models/item"
require_relative "../models/employee"
require_relative "../controllers/machines_controller.rb"
require_relative "../controllers/sessions_controller.rb"
require_relative "../repositories/employee_repository.rb"
require_relative "../repositories/transactionlog_repository.rb"
require_relative "../repositories/item_repository.rb"
require_relative "support/csv_helper"

describe "Item", :item do
  it "should be initialized with a hash of properties" do
    properties = { id: 1, name: "test", price: 1, quantity: 1}
    item = Item.new(properties)
    expect(item).to be_a(Item)
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


# describe "TransactionLogRepository", :transactionlog_repository do
#   let(:csv_path) { "spec/support/transactionlog_repository.csv" }
#   let(:repository) { TransactionlogRepository.new(csv_path) }
#   let(:transactionlog) do
#     [
#       ["id","item_quantity","total_price","item_id", "datetime"],
#       ["1","1","130","6","2020-02-04 16:26:32 +0000"],
#     ]
#     # ["id" => "1", "item_quantity" => "1", "total_price" => "130", "item_id" => "6", "datetime" => "2020-02-04 16:26:32 +0000"
#   # ]
#   end
#   before(:each) do
#     CsvHelper.write_csv(csv_path, transactionlog)
#   end

#   it 'creates an instance of TransactionLog' do
#     expect(repository.build_element(transactionlog[1])).to be_a(TransactionLog)
#   end

# end




