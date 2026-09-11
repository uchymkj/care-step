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
end
