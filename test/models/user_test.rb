require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "メールアドレスとパスワードがあれば有効である" do
    user = User.new(
      email: "test@example.com",
      password: "password"
    )

    assert user.valid?
  end

  test "メールアドレスがなければ無効である" do
    user = User.new(
      password: "password"
    )

    assert_not user.valid?
  end

  test "メールアドレスが重複していれば無効である" do
    User.create!(
      email: "duplicate@example.com",
      password: "password"
    )

    user = User.new(
      email: "duplicate@example.com",
      password: "password"
    )

    assert_not user.valid?
  end

  test "パスワードがなければ無効である" do
    user = User.new(
      email: "test@example.com"
    )

    assert_not user.valid?
  end

  test "正しいパスワードで認証できる" do
    user = User.create!(
      email: "authenticate@example.com",
      password: "password"
    )

    assert user.authenticate("password")
  end

  test "間違ったパスワードでは認証できない" do
    user = User.create!(
      email: "wrong-password@example.com",
      password: "password"
    )

    assert_not user.authenticate("wrong_password")
  end
end
