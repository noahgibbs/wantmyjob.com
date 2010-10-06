require 'test_helper'

class WorkSitesControllerTest < ActionController::TestCase
  setup do
    @work_site = work_sites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:work_sites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work_site" do
    assert_difference('WorkSite.count') do
      post :create, :work_site => @work_site.attributes
    end

    assert_redirected_to work_site_path(assigns(:work_site))
  end

  test "should show work_site" do
    get :show, :id => @work_site.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @work_site.to_param
    assert_response :success
  end

  test "should update work_site" do
    put :update, :id => @work_site.to_param, :work_site => @work_site.attributes
    assert_redirected_to work_site_path(assigns(:work_site))
  end

  test "should destroy work_site" do
    assert_difference('WorkSite.count', -1) do
      delete :destroy, :id => @work_site.to_param
    end

    assert_redirected_to work_sites_path
  end
end
