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
  end
end
