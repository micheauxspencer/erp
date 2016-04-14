namespace :insert_parents do
  desc "TODO"
  task insert_of_students: :environment do
    Student.all.each do |student|
      father = Parent.new(
        first_name: student.f_first_name,
        last_name: student.f_last_name,
        gender: "Male",
        phone: student.f_phone,
        cell: student.f_cell,
        work: student.f_work,
        email: student.f_email,
        home_address: student.f_home_address,
        city: student.f_city,
        state: student.f_state,
      )

      mother = Parent.new(
        first_name: student.m_first_name,
        last_name: student.m_last_name,
        gender: "Female",
        phone: student.m_phone,
        cell: student.m_cell,
        work: student.m_work,
        email: student.m_email,
        home_address: student.m_home_address,
        city: student.m_city,
        state: student.m_state,
      )

      if father.valid? && father.save
        StudentParent.create( student: student, parent: father )
      end

      if mother.valid? && mother.save
        StudentParent.create( student: student, parent: mother )
      end

    end
  end

end