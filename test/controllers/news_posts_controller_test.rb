require 'test_helper'

class NewsPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @news_post = news_posts(:one)
    @course = courses(:one)
    @teacher = users(:daniel)
    log_in_as @teacher
  end

  test "should create news_post" do
    assert_difference('NewsPost.count') do
      post news_posts_url, params: { news_post: { content: @news_post.content, name: @news_post.name, news_feed_id: @course.id, news_feed_type: 'Course' } }
    end

    assert_redirected_to @course
  end

  test "should get show" do
    get news_post_url(@news_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_news_post_url(@news_post)
    assert_response :success
  end

  test "should update news_post" do
    patch news_post_url(@news_post), params: { news_post: { content: @news_post.content, name: 'New Name' } }
    assert_equal 'New Name', @news_post.reload.name
    assert_redirected_to @news_post
  end

  test "should destroy news_post" do
    assert_difference('NewsPost.count', -1) do
      delete news_post_url(@news_post)
    end

    assert_redirected_to news_posts_url
  end
end
