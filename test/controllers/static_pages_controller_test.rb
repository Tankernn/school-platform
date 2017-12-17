require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    log_in_as users(:daniel)
  end

  test "should get home" do
    get home_url
    assert_response :success
    assert_select "title", "Home | School Platform"
  end

  test "should get about" do
    get about_url
    assert_response :success
    assert_select "title", "About | School Platform"
  end

end
