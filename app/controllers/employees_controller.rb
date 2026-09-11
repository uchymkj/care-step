class EmployeesController < ApplicationController
  layout "logged_in"

  before_action :require_login
  
  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      redirect_to @employee
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @employee = Employee.find(params[:id])
  end

  private

  def employee_params
    params.require(:employee).permit(
      :name,
      :department_id,
      :expected_delivery_date
    )
  end
end
