module StudentsHelper
  def get_health_issue(student)
    return student.medical_conditions.present? ? "<span style='color: red'>Yes</span>" : "No"
  end

  def get_enrolled(student)
    return student.enrolled.present? ? "<span style='color: red'>Yes</span>" : "No"
  end
  
end
