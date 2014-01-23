require 'test_helper'

class ResolutionsControllerTest < ActionController::TestCase
  setup do
    @resolution = resolutions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resolutions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resolution" do
    assert_difference('Resolution.count') do
      post :create, resolution: { committee_id: @resolution.committee_id, status_id: @resolution.status_id, user_id: @resolution.user_id, votes_against: @resolution.votes_against, votes_for: @resolution.votes_for }
    end

    assert_redirected_to resolution_path(assigns(:resolution))
  end

  test "should show resolution" do
    get :show, id: @resolution
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @resolution
    assert_response :success
  end

  test "should update resolution" do
    put :update, id: @resolution, resolution: { committee_id: @resolution.committee_id, status_id: @resolution.status_id, user_id: @resolution.user_id, votes_against: @resolution.votes_against, votes_for: @resolution.votes_for }
    assert_redirected_to resolution_path(assigns(:resolution))
  end

  test "should destroy resolution" do
    assert_difference('Resolution.count', -1) do
      delete :destroy, id: @resolution
    end

    assert_redirected_to resolutions_path
  end
end
