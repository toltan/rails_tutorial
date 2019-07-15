require 'test_helper'

class AccountActivationEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:michael)
    @non_activated_user = users(:non_activated_user)
  end
  
  test "should allow the activated attribute" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_not flash.any?
    assert_select "a[href=?]", user_path(@non_activated_user), count: 0
    assert_select "a[href=?]", user_path(@admin), count: 2
  end
  
  test "should not allow the not activated attribute" do
    log_in_as(@non_activated_user)
    get users_path
    assert_not @non_activated_user.activated?
    assert_select "a[href=?]", user_path(@non_activated_user), count: 0
    assert_redirected_to login_url
    get user_path(@non_activated_user)
    assert_redirected_to root_url
  end
end