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

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])

    if @employee.update(employee_params)
      redirect_to @employee
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to dashboard_path
  end

  private

  def employee_params
    params.require(:employee).permit(
      :name,
      :department_id,
      :expected_delivery_date,
      :delivery_date,
      :maternity_leave_start_date,
      :maternity_leave_end_date,
      :childcare_leave_start_date,
      :childcare_leave_end_date
    )
  end
end
