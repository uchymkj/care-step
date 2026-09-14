class EmployeeProceduresController < ApplicationController
  layout "logged_in"

  before_action :require_login

  def index
    @employee = Employee.find(params[:employee_id])
    @employee_procedures = @employee.employee_procedures.includes(:procedure_type)
  end
end
