require_relative "../models/item"
require_relative "../controllers/machines_controller.rb"
require_relative "../controllers/sessions_controller.rb"
require_relative "../repositories/employee_repository.rb"
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
      [ "id", "username", "password" ],
      [ 1, "paul", "secret"],
    ]
  end
  let(:csv_path) { "spec/support/employee_repository.csv" }
  let(:repository) { EmployeeRepository.new(csv_path) }

  before(:each) do
    CsvHelper.write_csv(csv_path, employee)
  end
end

  # describe "#sign_in" do
    # module Kernel; def gets; STDIN.gets; end; end
    describe SessionsController do
      it 'should not allow to log in if credentials are wrong' do
        controller = SessionsController.new(repository)

      end
    end

describe "ItemRepository", :item_repository do
  let(:csv_path) { "spec/support/item_repository.csv" }
  let(:repository) { ItemRepository.new(csv_path) }
  before(:each) do
    CsvHelper.write_csv(csv_path, item)
  end
end
