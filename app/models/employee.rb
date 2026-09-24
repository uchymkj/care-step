class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_procedures, dependent: :destroy

  after_create :create_employee_procedures

  def latest_procedure
    employee_procedures.find(&:in_progress?)
  end

  private

  def create_employee_procedures
    ProcedureType.find_each do |procedure_type|
      employee_procedures.create!(
        procedure_type: procedure_type,
        status: procedure_type.name == "産前産後休業申出" ? :in_progress : :not_started
      )
    end
  end
end
