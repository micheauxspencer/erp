# Create a default user
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', user_name: 'admin')

User.create!([
  {email: "office@example.com", password: "password", password_confirmation: "password", first_name: "Dao", last_name: "Colin", role: "office", user_name: "office"},
  {email: "assistant@example.com", password: "password", password_confirmation: "password", first_name: "Dao", last_name: "Colin", role: "assistant", user_name: "assistant"},
  {email: "teacher@example.com", password: "password", password_confirmation: "password", first_name: "Dao", last_name: "Colin", role: "teacher", user_name: "teacher"},
])

ReportTemplate.create!([
  {name: "js_jk"},
  {name: "g1_g3"},
  {name: "g4_g6"},
  {name: "g7_g8"}
])

Term.create([
  {name: "Term 1 - 2015", acedemic_year_id: nil},
  {name: "Term 2 - 2015", acedemic_year_id: nil},
  {name: "Term 3 - 2015", acedemic_year_id: nil}
])

term = Term.last

fee = Fee.create(name: "Term Fee", amount: 150.0, fee_caregory_id: nil, category: nil, term_id: 1)

route = Route.create(name: "Hanoi - Saigon", details: "", status: true)
teacher = User.where(role: "teacher").first

ReportTemplate.all.each_with_index do |report_template, index| 
  grade =  Grade.create( name: "Grade" + index.to_s,
                         teacher_id: teacher.id,
                         term_id: term.id,
                         report_template_id: report_template.id)

  student = Student.create!(first_name: "Dao", 
                            last_name: "Colin", 
                            sin: nil, 
                            birthdate: "1990-12-17", 
                            trans_req: true, 
                            tax_rec_req: false, 
                            route_fee: nil, 
                            pick_up: nil, 
                            drop_off: nil, 
                            sibling_id: nil, 
                            f_first_name: "", 
                            f_last_name: "", 
                            f_province: nil, 
                            f_phone: "", 
                            m_first_name: "", 
                            m_last_name: "", 
                            m_province: nil, 
                            m_phone: "", 
                            email: nil, 
                            emerg_1_name: "", 
                            emerg_1_phone: "", 
                            emerg_1_relation: "", 
                            emerg_2_name: nil, 
                            emerg_2_phone: nil, 
                            emerg_2_relation: nil, 
                            healthcard: "", 
                            doctor_name: "", 
                            doctor_phone: "", 
                            enrolled: nil, 
                            middle_name: "", 
                            last_shool_attended: "", 
                            last_school_phone: "", 
                            custody: "", 
                            nearest_intersection: nil, 
                            health_notes: nil, 
                            street: "", 
                            city: "", 
                            postal_code: "", 
                            gender: "Male", 
                            status: "", 
                            f_cell: "", 
                            m_cell: "", 
                            f_work: "", 
                            m_work: "", 
                            f_email: "", 
                            m_email: "", 
                            medical_conditions: "", 
                            medicated: nil, 
                            medication: nil, 
                            grade_id: grade.id, 
                            route_id: route.id)
  GradeStudent.create(grade_id: grade.id, student_id: student.id)
end
