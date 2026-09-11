class DashboardController < ApplicationController
  layout "logged_in"
  
  before_action :require_login
  
  def index
    @employees = Employee.includes(:department, employee_procedures: :procedure_type)
  end
end
