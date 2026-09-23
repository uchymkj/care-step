class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_procedures, dependent: :destroy

  after_create :create_employee_procedures

  def latest_procedure
    employee_procedures.max_by(&:created_at)
  end

  private

  def create_employee_procedures
    ProcedureType.find_each do |procedure_type|
      employee_procedures.create!(
        procedure_type: procedure_type,
        status: :not_started
      )
    end
  end
end
