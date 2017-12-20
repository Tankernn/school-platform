require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(login: "example", name: "Example User",
                     email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar",
                     birth_date: 30.years.ago)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "login should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "login should not be too long" do
    @user.login = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 256
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

  test "login validation should accept valid login" do
    valid_logins = %w[foobar FooBar Foo_Bar 1234_Foo_Bar_5678]
    valid_logins.each do |valid_login|
      @user.login = valid_login
      assert @user.valid?, "#{valid_login.inspect} should be valid"
    end
  end

  test "login validation should reject invalid login" do
    invalid_logins = %w[foo:bar Foo*Bar Foo_^^Bar 1234!"_Foo_Bar_-5678]
    invalid_logins.each do |invalid_login|
      @user.login = invalid_login
      assert_not @user.valid?, "#{invalid_login.inspect} should be invalid"
    end
  end

  test "phone number validation should accept valid phone number" do
    valid_numbers = [
      "333-333-3333",
      "(333) 333-3333",
      "1-333-333-3333",
      "333.333.3333",
      "333-333-3333",
      "333-333-3333 x3333",
      "(333) 333-3333 x3333",
      "1-333-333-3333 x3333",
      "333.333.3333 x3333",
    ]
    valid_numbers.each do |valid_number|
      @user.phone = valid_number
      assert @user.valid?, "#{valid_number.inspect} should be valid"
    end
  end

  test "login should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = "foo@bar.com"
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.login = "bar_foo"
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
