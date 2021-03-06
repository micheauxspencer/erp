json.array!(@students) do |student|
  json.extract! student, :id, :first_name, :last_name, :grade_id, :sin, :birthdate, :trans_req, :tax_rec_req, :route_id, :route_fee, :pick_up, :drop_off, :sibling_id, :f_first_name, :f_last_name, :f_street, :f_city, :f_province, :f_postalf_phone, :email, :emerg_1_name, :emerg_1_phone, :emerg_1_relation, :healthcard, :doctor_name, :doctor_phone
  json.url student_url(student, format: :json)
end
