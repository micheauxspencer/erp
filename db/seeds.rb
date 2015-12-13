AdminUser.create!([
  {email: "admin@example.com", encrypted_password: "$2a$10$i6aVmy1lXXTMiipVeTI3fOzYLQgLi/0Tyqx1TksUNxGNc5mYx/4IC", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, user_name: "admin"}
])
User.create!([
  {email: "office@example.com", encrypted_password: "$2a$10$Ls6FGc00KghumPV8LI18EOsIH4.9wmiVBKDTkNQZ3np1EH09hp7ri", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 2, current_sign_in_at: "2015-12-13 02:27:47", last_sign_in_at: "2015-12-13 01:42:06", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", role: "office", user_name: "office", first_name: nil, last_name: nil, address: nil, birth_date: nil, phone: nil},
  {email: "teacher@example.com", encrypted_password: "$2a$10$fZBwxzRjDKp1bIaZGQS0gOaU/Z4T8MTMIC6L4bh8ZKgDS4X7JMC7e", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2015-12-13 02:22:53", last_sign_in_at: "2015-12-13 02:22:53", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", role: "teacher", user_name: "teacher", first_name: nil, last_name: nil, address: nil, birth_date: nil, phone: nil},
  {email: "assistant@example.com", encrypted_password: "$2a$10$jjW68F223dy.zu0NYevAOOBe1LLfTn4AEyZ1b/utUIew2mNIX/dWq", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2015-12-13 02:28:38", last_sign_in_at: "2015-12-13 02:28:38", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", role: "assistant", user_name: "assistant", first_name: nil, last_name: nil, address: nil, birth_date: nil, phone: nil}
])
Fee.create!([
  {name: "Term Fee", amount: 150.0, fee_caregory_id: nil, category: nil, term_id: 1}
])
Grade.create!([
  {name: "3A", teacher_id: 2, term_id: 1, report_template_id: 6}
])
GradeStudent.create!([
  {grade_id: 1, student_id: 1}
])
ReportTemplate.create!([
  {name: "js_jk"},
  {name: "g1_g3"},
  {name: "g4_g6"},
  {name: "g7_g8"}
])
Route.create!([
  {name: "Hanoi - Saigon", details: "", status: true}
])
Student.create!([
  {first_name: "Dao", last_name: "Colin", sin: nil, birthdate: "1990-12-17", trans_req: true, tax_rec_req: false, route_fee: nil, pick_up: nil, drop_off: nil, sibling_id: nil, f_first_name: "", f_last_name: "", f_province: nil, f_phone: "", m_first_name: "", m_last_name: "", m_province: nil, m_phone: "", email: nil, emerg_1_name: "", emerg_1_phone: "", emerg_1_relation: "", emerg_2_name: nil, emerg_2_phone: nil, emerg_2_relation: nil, healthcard: "", doctor_name: "", doctor_phone: "", enrolled: nil, middle_name: "", last_shool_attended: "", last_school_phone: "", custody: "", nearest_intersection: nil, health_notes: nil, street: "", city: "", postal_code: "", gender: "Male", status: "", f_cell: "", m_cell: "", f_work: "", m_work: "", f_email: "", m_email: "", medical_conditions: "", medicated: nil, medication: nil, grade_id: nil, route_id: 1}
])
Term.create!([
  {name: "Term 3 - 2015", acedemic_year_id: nil}
])
