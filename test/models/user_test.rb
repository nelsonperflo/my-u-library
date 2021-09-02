require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @role = roles(:librarian)
    @user = User.new(first_name: "Example", last_name: "User", email: "user@example.com",
                     password: "Fargo01$", password_confirmation: "Fargo01$", role_id: @role.id)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "first name should be present" do
    @user.first_name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 7
    assert_not @user.valid?
  end

  test "password should have lowercase and capital letters, numbers and symbols" do
    @user.password = @user.password_confirmation = "fargoabc"
    assert_not @user.valid?
    @user.password = @user.password_confirmation = "Fargoabc"
    assert_not @user.valid?
    @user.password = @user.password_confirmation = "Fargoabc01"
    assert_not @user.valid?
    @user.password = @user.password_confirmation = "Fargo01$-"
    assert @user.valid?
  end

  test "role should be present" do
    @user.role = nil
    assert_not @user.valid?
  end

end
