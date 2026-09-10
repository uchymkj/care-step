require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      email: "test@example.com",
      password: "password"
    )
  end
  
  test "should get new" do
    get root_url
    assert_response :success
  end

  test "should login with correct credentials" do
    post login_url, params: {
      email: @user.email,
      password: "password"
    }

    assert_redirected_to dashboard_url
  end

  test "should not login with incorrect password" do
    post login_url, params: {
      email: @user.email,
      password: "wrong"
    }

    assert_response :unprocessable_entity
  end

  test "should logout" do
    post login_url, params: {
      email: @user.email,
      password: "password"
    }

    delete logout_url

    assert_redirected_to root_url

    get dashboard_url
    assert_redirected_to root_url
  end
end
