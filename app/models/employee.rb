class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_procedures

  def latest_procedure
    employee_procedures.max_by(&:created_at)
  end
end
