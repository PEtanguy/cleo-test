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
    expect(repository("pierre@cleo.com")).to be_a(Employee)
  end

  # context 'password is valid' do
  #   expect()
  # end

  # context 'password is invalid' do
  #   it 'xxx' do
  #   end
  # end

end

  # describe "#sign_in" do
    # module Kernel; def gets; STDIN.gets; end; end
    # describe SessionsController do
    #     let(:csv_path) { "spec/support/employee_repository.csv" }
    #     let(:repository) { EmployeeRepository.new(csv_path) }
    #   it 'should not allow to log in if credentials are wrong' do
    #     controller = SessionsController.new(repository)
    #     expect(controller.signin.to be_a(employee)
    #   end
    # end

describe "ItemRepository", :item_repository do
  let(:csv_path) { "spec/support/item_repository.csv" }
  let(:repository) { ItemRepository.new(csv_path) }
  before(:each) do
    CsvHelper.write_csv(csv_path, item)
  end
end


describe "TransactionLogRepository", :transactionlog_repository do
  let(:csv_path) { "spec/support/transactionlog_repository.csv" }
  let(:repository) { TransactionlogRepository.new(csv_path) }
  let(:transactionlog) do
    [
      ["id","item_quantity","total_price","item_id"],
      ["1","1","130","6","2020-02-04 16:26:32 +0000"],
    ]
  end
  before(:each) do
    CsvHelper.write_csv(csv_path, transactionlog)
  end

  it 'creates an instance of TransactionLog' do
    expect(repository.build_element(transactionlog[1])).to be_a(TransactionLog)
  end

end


