require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "logged in layout links" do
    log_in_as users(:daniel)
    get home_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", home_path
    assert_select "a[href=?]", about_path
  end

  test "logged out" do
    get home_path
    assert_redirected_to login_url
    follow_redirect!
    assert_template 'sessions/new'
    assert_select "nav", count: 0
  end
end
