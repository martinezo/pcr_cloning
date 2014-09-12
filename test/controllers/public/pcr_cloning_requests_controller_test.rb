require 'test_helper'

class Public::PcrCloningRequestsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get sent" do
    get :sent
    assert_response :success
  end

  test "should get pdf_req_download" do
    get :pdf_req_download
    assert_response :success
  end

end
