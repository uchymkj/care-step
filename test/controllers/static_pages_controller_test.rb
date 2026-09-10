require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  setup do
    @user = User.create!(
      email: "static_pages@example.com",
      password: "password"
    )
  end

  test "should get terms when logged in" do
    post login_url, params: {
      email: @user.email,
      password: "password"
    }

    get terms_url

    assert_response :success
    assert_select "h1", text: "利用規約"
  end

  test "should redirect terms when not logged in" do
    get terms_url

    assert_redirected_to root_url
  end

  test "should get privacy when logged in" do
    post login_url, params: {
      email: @user.email,
      password: "password"
    }

    get privacy_url

    assert_response :success
    assert_select "h1", text: "プライバシーポリシー"
  end

  test "should redirect privacy when not logged in" do
    get privacy_url

    assert_redirected_to root_url
  end
end
