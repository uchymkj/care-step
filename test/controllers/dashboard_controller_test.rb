require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  setup do
    @user = User.create!(
      email: "dashboard@example.com",
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

    EmployeeProcedure.create!(
      employee: @employee,
      procedure_type: @procedure_type,
      deadline: Date.new(2026, 11, 1),
      status: :in_progress
    )
  end

  test "should redirect to root when not logged in" do
    get dashboard_url

    assert_redirected_to root_url
  end

  test "should get index when logged in" do
    post login_url, params: {
      email: @user.email,
      password: "password"
    }

    get dashboard_url

    assert_response :success
    assert_select "header", text: /ケアすてっぷ/
    assert_select "header", text: /#{@user.email}/
    assert_select "footer", text: /利用規約/
    assert_select "footer", text: /プライバシーポリシー/

    assert_select "a", text: "新規社員登録"
    assert_select "a", text: @employee.name
    assert_select "td", text: @department.name
    assert_select "td", text: "2026-12-01"
    assert_select "td", text: @procedure_type.name
    assert_select "td", text: "対応中"
  end
end
