class EmployeeProcedure < ApplicationRecord
  belongs_to :employee
  belongs_to :procedure_type

  enum status: {
    not_started: 0,
    in_progress: 1,
    completed: 2
  }

  def status_label
    {
      "not_started" => "未着手",
      "in_progress" => "対応中",
      "completed" => "完了"
    }[status]
  end
end
