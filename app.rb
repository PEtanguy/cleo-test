require_relative "models/item"
require_relative "models/transactionlog.rb"
require_relative "models/employee.rb"

require_relative "repositories/employee_repository"
require_relative "repositories/transactionlog_repository"
require_relative "repositories/base"
require_relative "repositories/item_repository.rb"

require_relative "controllers/sessions_controller"
require_relative "controllers/transactionlogs_controller"
require_relative "controllers/machines_controller.rb"

require_relative "router"

employees_csv = File.join(__dir__,"data/employees.csv")
employee_repository = EmployeeRepository.new(employees_csv)
sessions_controller = SessionsController.new(employee_repository)

transactionlog_csv = File.join(__dir__,"data/transactionlog.csv")
transactionlog_repository = TransactionlogRepository.new(transactionlog_csv)
transactionlogs_controller = TransactionlogsController.new(transactionlog_repository, sessions_controller)

items_csv = File.join(__dir__,"data/items.csv")
item_repository = ItemRepository.new(items_csv)
machines_controller = MachinesController.new(item_repository, transactionlog_repository, sessions_controller)


router = Router.new(machines_controller, transactionlogs_controller)
router.run
