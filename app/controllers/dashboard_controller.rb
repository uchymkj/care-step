class DashboardController < ApplicationController
  layout "logged_in"

  before_action :require_login

  def index
    @employees = Employee.includes(:department, current_procedure: :procedure_type)
  end
end
