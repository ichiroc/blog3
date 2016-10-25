require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get approve" do
    get comments_approve_url
    assert_response :success
  end

end
