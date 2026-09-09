class EmployeeProcedure < ApplicationRecord
  belongs_to :employee
  belongs_to :procedure_type

  enum status: {
    not_started: 0,
    in_progress: 1,
    completed: 2
  }
end
