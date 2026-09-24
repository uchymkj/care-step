require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "対応中の手続を最新の手続として取得できる" do
    department = departments(:two)

    employee = Employee.create!(
      name: "山田 花子",
      department: department,
      expected_delivery_date: Date.new(2026, 12, 1)
    )

    employee.employee_procedures.destroy_all

    old_procedure_type = ProcedureType.create!(
      name: "産前産後休業申出テスト"
    )

    latest_procedure_type = ProcedureType.create!(
      name: "育児休業申出テスト"
    )

    old_procedure = EmployeeProcedure.create!(
      employee: employee,
      procedure_type: old_procedure_type,
      status: :completed,
      created_at: 2.days.ago
    )

    latest_procedure = EmployeeProcedure.create!(
      employee: employee,
      procedure_type: latest_procedure_type,
      status: :in_progress,
      created_at: 3.days.ago
    )

    employee.employee_procedures.reload
    assert_equal latest_procedure, employee.latest_procedure
    assert_not_equal old_procedure, employee.latest_procedure
  end
end
