# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160601150207) do

  create_table "acedemic_year_grades", force: true do |t|
    t.integer  "acedemic_year_id"
    t.integer  "grade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "acedemic_years", force: true do |t|
    t.integer  "year"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_name"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "attendances", force: true do |t|
    t.integer  "user_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "term_id"
    t.integer  "grade_id"
    t.string   "type_action"
    t.date     "attendanced_at"
  end

  add_index "attendances", ["student_id"], name: "index_attendances_on_student_id"
  add_index "attendances", ["term_id"], name: "index_attendances_on_term_id"

  create_table "charges", force: true do |t|
    t.integer  "student_id"
    t.integer  "fee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "term_id"
    t.integer  "amount"
    t.boolean  "is_completed", default: false
  end

  add_index "charges", ["term_id"], name: "index_charges_on_term_id"

  create_table "comments", force: true do |t|
    t.integer  "term_student_id"
    t.string   "content",         limit: 2000
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["term_student_id"], name: "index_comments_on_term_student_id"

  create_table "curriculars", force: true do |t|
    t.integer  "student_id"
    t.string   "content",          limit: 2000
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "acedemic_year_id"
  end

  add_index "curriculars", ["student_id"], name: "index_curriculars_on_student_id"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "enrollments", force: true do |t|
    t.integer  "acedemic_year_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "term_id"
  end

  add_index "enrollments", ["term_id"], name: "index_enrollments_on_term_id"

  create_table "evaluate_types", force: true do |t|
    t.string   "name"
    t.integer  "report_template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "evaluate_types", ["report_template_id"], name: "index_evaluate_types_on_report_template_id"

  create_table "evaluates", force: true do |t|
    t.string   "name"
    t.integer  "evaluate_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "report_template_id"
    t.integer  "mark_type"
  end

  add_index "evaluates", ["evaluate_type_id"], name: "index_evaluates_on_evaluate_type_id"
  add_index "evaluates", ["report_template_id"], name: "index_evaluates_on_report_template_id"

  create_table "fee_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fees", force: true do |t|
    t.string   "name"
    t.float    "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fee_caregory_id"
    t.string   "category"
    t.integer  "term_id"
  end

  add_index "fees", ["term_id"], name: "index_fees_on_term_id"

  create_table "grade_students", force: true do |t|
    t.integer "grade_id"
    t.integer "student_id"
  end

  add_index "grade_students", ["grade_id"], name: "index_grade_students_on_grade_id"
  add_index "grade_students", ["student_id"], name: "index_grade_students_on_student_id"

  create_table "grades", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "teacher_id"
    t.integer  "term_id"
    t.integer  "report_template_id"
    t.integer  "acedemic_year_id"
  end

  add_index "grades", ["term_id"], name: "index_grades_on_term_id"

  create_table "graduations", force: true do |t|
    t.integer  "student_id"
    t.integer  "grade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parents", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.date     "birthdate"
    t.string   "phone"
    t.string   "cell"
    t.string   "work"
    t.string   "email"
    t.string   "home_address"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_templates", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.integer  "type"
    t.string   "category"
    t.integer  "indicator"
    t.integer  "teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "term_id"
    t.integer  "grade_id"
  end

  add_index "reports", ["term_id"], name: "index_reports_on_term_id"

  create_table "routes", force: true do |t|
    t.string   "name"
    t.string   "details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status"
  end

  create_table "student_evaluates", force: true do |t|
    t.integer  "term_student_id"
    t.integer  "evaluate_id"
    t.integer  "mark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "avg"
  end

  add_index "student_evaluates", ["evaluate_id"], name: "index_student_evaluates_on_evaluate_id"
  add_index "student_evaluates", ["term_student_id"], name: "index_student_evaluates_on_term_student_id"

  create_table "student_parents", force: true do |t|
    t.integer  "student_id"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "student_parents", ["parent_id"], name: "index_student_parents_on_parent_id"
  add_index "student_parents", ["student_id"], name: "index_student_parents_on_student_id"

  create_table "student_siblings", force: true do |t|
    t.integer  "student_id"
    t.integer  "sibling_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "sin"
    t.date     "birthdate"
    t.boolean  "trans_req"
    t.boolean  "tax_rec_req"
    t.string   "route_fee"
    t.boolean  "pick_up"
    t.boolean  "drop_off"
    t.integer  "sibling_id"
    t.string   "f_first_name"
    t.string   "f_last_name"
    t.string   "f_province"
    t.string   "f_phone"
    t.string   "m_first_name"
    t.string   "m_last_name"
    t.string   "m_province"
    t.string   "m_phone"
    t.string   "email"
    t.string   "emerg_1_name"
    t.string   "emerg_1_phone"
    t.string   "emerg_1_relation"
    t.string   "emerg_2_name"
    t.string   "emerg_2_phone"
    t.string   "emerg_2_relation"
    t.string   "healthcard"
    t.string   "doctor_name"
    t.string   "doctor_phone"
    t.boolean  "enrolled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "middle_name"
    t.string   "last_shool_attended"
    t.string   "last_school_phone"
    t.text     "custody"
    t.string   "nearest_intersection"
    t.text     "health_notes"
    t.string   "street"
    t.string   "city"
    t.string   "postal_code"
    t.string   "gender"
    t.string   "status"
    t.string   "f_cell"
    t.string   "m_cell"
    t.string   "f_work"
    t.string   "m_work"
    t.string   "f_email"
    t.string   "m_email"
    t.text     "medical_conditions"
    t.boolean  "medicated"
    t.string   "medication"
    t.integer  "grade_id"
    t.integer  "route_id"
    t.string   "state"
    t.string   "nationality"
    t.string   "category"
    t.string   "country"
    t.string   "immediate_contact"
    t.string   "biometric"
    t.datetime "admission_date"
    t.string   "f_home_address"
    t.string   "f_city"
    t.string   "f_state"
    t.string   "m_home_address"
    t.string   "m_city"
    t.string   "m_state"
    t.string   "phone"
    t.string   "mobile"
    t.boolean  "transferred",          default: false
    t.integer  "enrollment_year"
  end

  add_index "students", ["grade_id"], name: "index_students_on_grade_id"
  add_index "students", ["route_id"], name: "index_students_on_route_id"

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teacher_attendances", force: true do |t|
    t.integer  "teacher_id"
    t.integer  "work_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "term_grades", force: true do |t|
    t.integer  "term_id"
    t.integer  "grade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "term_grades", ["grade_id"], name: "index_term_grades_on_grade_id"
  add_index "term_grades", ["term_id"], name: "index_term_grades_on_term_id"

  create_table "term_students", force: true do |t|
    t.integer  "term_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "term_students", ["student_id"], name: "index_term_students_on_student_id"
  add_index "term_students", ["term_id"], name: "index_term_students_on_term_id"

  create_table "terms", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "acedemic_year_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "status",           default: "Inactive"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "user_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.datetime "birth_date"
    t.string   "phone"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "year_classes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "year_fees", force: true do |t|
    t.integer  "acedemic_year_id"
    t.integer  "fee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "year_grades", force: true do |t|
    t.integer  "acedemic_year_id"
    t.integer  "grade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "year_routes", force: true do |t|
    t.integer  "acedemic_year_id"
    t.integer  "route_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
