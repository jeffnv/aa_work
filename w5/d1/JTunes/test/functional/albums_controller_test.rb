require 'test_helper'

class AlbumsControllerTest < ActionController::TestCase
  test "should get newrails" do
    get :newrails
    assert_response :success
  end

  test "should get g" do
    get :g
    assert_response :success
  end

  test "should get controller" do
    get :controller
    assert_response :success
  end

  test "should get Albums" do
    get :Albums
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
