require 'test_helper'

class StudentsControllerTest < ActionController::TestCase
  setup do
    @student = students(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:students)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student" do
    assert_difference('Student.count') do
      post :create, student: { birthdate: @student.birthdate, doctor_name: @student.doctor_name, doctor_phone: @student.doctor_phone, drop_off: @student.drop_off, email: @student.email, emerg_1_name: @student.emerg_1_name, emerg_1_phone: @student.emerg_1_phone, emerg_1_relation: @student.emerg_1_relation, f_city: @student.f_city, f_first_name: @student.f_first_name, f_last_name: @student.f_last_name, f_postalf_phone: @student.f_postalf_phone, f_province: @student.f_province, f_street: @student.f_street, first_name: @student.first_name, grade_id: @student.grade_id, healthcard: @student.healthcard, last_name: @student.last_name, pick_up: @student.pick_up, route_fee: @student.route_fee, route_id: @student.route_id, sibling_id: @student.sibling_id, sin: @student.sin, tax_rec_req: @student.tax_rec_req, trans_req: @student.trans_req }
    end

    assert_redirected_to student_path(assigns(:student))
  end

  test "should show student" do
    get :show, id: @student
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @student
    assert_response :success
  end

  test "should update student" do
    patch :update, id: @student, student: { birthdate: @student.birthdate, doctor_name: @student.doctor_name, doctor_phone: @student.doctor_phone, drop_off: @student.drop_off, email: @student.email, emerg_1_name: @student.emerg_1_name, emerg_1_phone: @student.emerg_1_phone, emerg_1_relation: @student.emerg_1_relation, f_city: @student.f_city, f_first_name: @student.f_first_name, f_last_name: @student.f_last_name, f_postalf_phone: @student.f_postalf_phone, f_province: @student.f_province, f_street: @student.f_street, first_name: @student.first_name, grade_id: @student.grade_id, healthcard: @student.healthcard, last_name: @student.last_name, pick_up: @student.pick_up, route_fee: @student.route_fee, route_id: @student.route_id, sibling_id: @student.sibling_id, sin: @student.sin, tax_rec_req: @student.tax_rec_req, trans_req: @student.trans_req }
    assert_redirected_to student_path(assigns(:student))
  end

  test "should destroy student" do
    assert_difference('Student.count', -1) do
      delete :destroy, id: @student
    end

    assert_redirected_to students_path
  end
end
