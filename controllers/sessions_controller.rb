require_relative "../views/sessions_view.rb"

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionsView.new
  end

  def sign_in
    email = @view.ask_for(:Email)
    password = @view.ask_for(:Password)

    employee = @employee_repository.find_by_email(email)
    check_password(employee, password)
  end

  def check_password(employee, password)
    if employee && employee.password == password
      return employee
    else
      @view.wrong_credentials
      sign_in
    end
  end
end
