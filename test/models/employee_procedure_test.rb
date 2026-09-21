require "test_helper"

class EmployeeProcedureTest < ActiveSupport::TestCase
  test "進捗を未着手として設定できる" do
    employee_procedure = EmployeeProcedure.new(status: :not_started)

    assert employee_procedure.not_started?
    assert_equal "未着手", employee_procedure.status_label
  end

  test "進捗を対応中として設定できる" do
    employee_procedure = EmployeeProcedure.new(status: :in_progress)

    assert employee_procedure.in_progress?
    assert_equal "対応中", employee_procedure.status_label
  end

  test "進捗を完了として設定できる" do
    employee_procedure = EmployeeProcedure.new(status: :completed)

    assert employee_procedure.completed?
    assert_equal "完了", employee_procedure.status_label
  end
end
