require 'test_helper'

class AcedemicYearsControllerTest < ActionController::TestCase
  setup do
    @acedemic_year = acedemic_years(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:acedemic_years)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create acedemic_year" do
    assert_difference('AcedemicYear.count') do
      post :create, acedemic_year: { end_date: @acedemic_year.end_date, start_date: @acedemic_year.start_date, year: @acedemic_year.year }
    end

    assert_redirected_to acedemic_year_path(assigns(:acedemic_year))
  end

  test "should show acedemic_year" do
    get :show, id: @acedemic_year
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @acedemic_year
    assert_response :success
  end

  test "should update acedemic_year" do
    patch :update, id: @acedemic_year, acedemic_year: { end_date: @acedemic_year.end_date, start_date: @acedemic_year.start_date, year: @acedemic_year.year }
    assert_redirected_to acedemic_year_path(assigns(:acedemic_year))
  end

  test "should destroy acedemic_year" do
    assert_difference('AcedemicYear.count', -1) do
      delete :destroy, id: @acedemic_year
    end

    assert_redirected_to acedemic_years_path
  end
end
