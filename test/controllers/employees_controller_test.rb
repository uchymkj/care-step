require "test_helper"

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = User.create!(
      email: "employees@example.com",
      password: "password"
    )

    @department = departments(:two)

    @employee = Employee.create!(
      name: "山田 花子",
      department: @department,
      expected_delivery_date: Date.new(2026, 12, 1),
      delivery_date: Date.new(2026, 12, 3),
      maternity_leave_start_date: Date.new(2026, 10, 21),
      maternity_leave_end_date: Date.new(2027, 1, 26),
      childcare_leave_start_date: Date.new(2027, 1, 27),
      childcare_leave_end_date: Date.new(2027, 12, 2)
    )

    @procedure_type = ProcedureType.create!(
      name: "育児休業申出"
    )

    EmployeeProcedure.create!(
      employee: @employee,
      procedure_type: @procedure_type,
      deadline: Date.new(2026, 11, 1),
      status: :in_progress
    )  
  end

  test "should get new when logged in" do
    post login_url, params: {
      email: @user.email,
      password: "password"
    }

    get new_employee_url

    assert_response :success
    assert_select "h1", text: "新規社員登録"
  end

  test "should redirect new when not logged in" do
    get new_employee_url

    assert_redirected_to root_url
  end

  test "should create employee" do
    post login_url, params: {
      email: @user.email,
      password: "password"
    }

    assert_difference("Employee.count", 1) do
      post employees_url, params: {
        employee: {
          name: "山田 花子",
          department_id: @department.id,
          expected_delivery_date: "2026-12-01"
        }
      }
    end

    employee = Employee.last

    assert_redirected_to employee_url(employee)
    assert_equal "山田 花子", employee.name
    assert_equal @department.id, employee.department_id
    assert_equal Date.new(2026, 12, 1), employee.expected_delivery_date
  end

  test "should get show when logged in" do
    post login_url, params: {
      email: @user.email,
      password: "password"
    }

    get employee_url(@employee)

    assert_response :success
    assert_select "h1", text: "社員詳細"
    assert_select "p", text: /#{@employee.name}/
    assert_select "p", text: /#{@department.name}/
    assert_select "p", text: /2026-12-01/
    assert_select "p", text: /2026-12-03/
    assert_select "p", text: /2026-10-21/
    assert_select "p", text: /2027-01-26/
    assert_select "p", text: /2027-01-27/
    assert_select "p", text: /2027-12-02/
    assert_select "p", text: /#{@procedure_type.name}/
    assert_select "p", text: /対応中/
    assert_select "button", text: "更新"
    assert_select "button", text: "削除"
    assert_select "a", text: "ダッシュボード"
  end

  test "should redirect show when not logged in" do
    get employee_url(@employee)

    assert_redirected_to root_url
  end
end
