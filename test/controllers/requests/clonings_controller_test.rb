require 'test_helper'

class Requests::CloningsControllerTest < ActionController::TestCase
  setup do
    @requests_cloning = requests_clonings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requests_clonings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create requests_cloning" do
    assert_difference('Requests::Cloning.count') do
      post :create, requests_cloning: { company: @requests_cloning.company, group_leader: @requests_cloning.group_leader, inv_address: @requests_cloning.inv_address, inv_city: @requests_cloning.inv_city, inv_mail: @requests_cloning.inv_mail, inv_municipality: @requests_cloning.inv_municipality, inv_name: @requests_cloning.inv_name, inv_rfc: @requests_cloning.inv_rfc, mail: @requests_cloning.mail, name: @requests_cloning.name, payment_method: @requests_cloning.payment_method, pcr_product_size: @requests_cloning.pcr_product_size, phone: @requests_cloning.phone, sample_name: @requests_cloning.sample_name, sample_volume: @requests_cloning.sample_volume, sequencing_type: @requests_cloning.sequencing_type, shipping_address: @requests_cloning.shipping_address, type: @requests_cloning.type }
    end

    assert_redirected_to requests_cloning_path(assigns(:requests_cloning))
  end

  test "should show requests_cloning" do
    get :show, id: @requests_cloning
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @requests_cloning
    assert_response :success
  end

  test "should update requests_cloning" do
    patch :update, id: @requests_cloning, requests_cloning: { company: @requests_cloning.company, group_leader: @requests_cloning.group_leader, inv_address: @requests_cloning.inv_address, inv_city: @requests_cloning.inv_city, inv_mail: @requests_cloning.inv_mail, inv_municipality: @requests_cloning.inv_municipality, inv_name: @requests_cloning.inv_name, inv_rfc: @requests_cloning.inv_rfc, mail: @requests_cloning.mail, name: @requests_cloning.name, payment_method: @requests_cloning.payment_method, pcr_product_size: @requests_cloning.pcr_product_size, phone: @requests_cloning.phone, sample_name: @requests_cloning.sample_name, sample_volume: @requests_cloning.sample_volume, sequencing_type: @requests_cloning.sequencing_type, shipping_address: @requests_cloning.shipping_address, type: @requests_cloning.type }
    assert_redirected_to requests_cloning_path(assigns(:requests_cloning))
  end

  test "should destroy requests_cloning" do
    assert_difference('Requests::Cloning.count', -1) do
      delete :destroy, id: @requests_cloning
    end

    assert_redirected_to requests_clonings_path
  end
end
