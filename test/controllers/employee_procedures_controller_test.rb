require "test_helper"

class EmployeeProceduresControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  setup do
    @user = User.create!(
      email: "employee_procedures@example.com",
      password: "password"
    )

    @department = departments(:two)

    @employee = Employee.create!(
      name: "山田 花子",
      department: @department,
      expected_delivery_date: Date.new(2026, 12, 1)
    )

    @procedure_type = ProcedureType.create!(
      name: "育児休業申出"
    )

    @employee_procedure = EmployeeProcedure.create!(
      employee: @employee,
      procedure_type: @procedure_type,
      deadline: Date.new(2026, 11, 1),
      status: :in_progress,
      notes: "申出書を確認する"
    )
  end

  test "should get index when logged in" do
    post login_url, params: {
      email: @user.email,
      password: "password"
    }

    get employee_employee_procedures_url(@employee)

    assert_response :success
    assert_select "h1", text: "手続一覧・進捗更新"
    assert_select "p", text: /#{@employee.name}/
    assert_select "td", text: @procedure_type.name
    assert_select "input[name='employee_procedure[deadline]'][value='2026-11-01']"
    assert_select "option[value='in_progress'][selected]", text: "対応中"
    assert_select "input[name='employee_procedure[notes]'][value='申出書を確認する']"
    assert_select "input[type='submit'][value='登録・更新']"
    assert_select "a", text: "社員詳細へ戻る"
  end

  test "should redirect index when not logged in" do
    get employee_employee_procedures_url(@employee)

    assert_redirected_to root_url
  end

  test "should update employee procedure" do
    post login_url, params: {
      email: @user.email,
      password: "password"
    }

    patch employee_employee_procedure_url(@employee, @employee_procedure), params: {
      employee_procedure: {
        deadline: "2026-11-10",
        status: "completed",
        notes: "申出書確認済み"
      }
    }

    @employee_procedure.reload

    assert_redirected_to employee_employee_procedures_url(@employee)
    assert_equal Date.new(2026, 11, 10), @employee_procedure.deadline
    assert_equal "completed", @employee_procedure.status
    assert_equal "申出書確認済み", @employee_procedure.notes
  end

  test "should redirect update when not logged in" do
    patch employee_employee_procedure_url(@employee, @employee_procedure), params: {
      employee_procedure: {
        deadline: "2026-11-10",
        status: "completed",
        notes: "申出書確認済み"
      }
    }

    assert_redirected_to root_url
  end  
end
