class EmployeeProceduresController < ApplicationController
  layout "logged_in"

  before_action :require_login

  def index
    @employee = Employee.find(params[:employee_id])
    @employee_procedures = @employee.employee_procedures.includes(:procedure_type)
  end

  def update
    @employee = Employee.find(params[:employee_id])
    @employee_procedure = @employee.employee_procedures.find(params[:id])

    if @employee_procedure.update(employee_procedure_params)
      redirect_to employee_employee_procedures_path(@employee)
    else
      @employee_procedures = @employee.employee_procedures.includes(:procedure_type)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def employee_procedure_params
    params.require(:employee_procedure).permit(
      :deadline,
      :status,
      :notes
    )
  end
end
