require_relative "../views/transactionlogs_view.rb"

class TransactionlogsController
  def initialize(transactionlog_repository, sessions_controller)
    @transactionlog_repository = transactionlog_repository
    @sessions_controller = sessions_controller
    @view = TransactionlogsView.new
  end

  def display_logs
    @employee = @sessions_controller.sign_in
    logs = @transactionlog_repository.all
    @view.display(logs)
  end
end
