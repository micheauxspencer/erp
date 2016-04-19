class StudentSiblingsController < ApplicationController
  def create
    if params[:student_id].present?
      student = Student.find(params[:student_id])

      if student.present?
        siblings = params[:siblings].split(',')
        unless siblings.empty?
          siblings.each do |sibling|
            StudentSibling.find_or_create_by(student_id: student.id, sibling_id: sibling.to_i)
            parents = student.parents
            unless parents.empty?
              parents.each do |parent|
                StudentParent.find_or_create_by(student_id: sibling.to_i, parent: parent)
              end
            end
          end
        end
      end
      @siblings = student.siblings
    else
      sibling_ar = params[:siblings].split(',').map{ |x| x.to_i } + params[:sibling_olds].split(',').map{ |x| x.to_i }
      @siblings = Student.where( id: sibling_ar )
    end

    respond_to do |format|
      format.js do
        @return_content = render_to_string(partial: 'students/list_student_sibling', locals: {siblings: @siblings})
      end
    end
  end

  def destroy
    if params[:student_id].present?
      student = Student.find(params[:student_id])
      sibling = StudentSibling.where(student_id: student.id, sibling_id: params[:sibling_id]).first
      sibling.destroy if sibling.present?
      parents = student.parents
      unless parents.empty?
        parents.each do |parent|
          parent = StudentParent.where(student_id: params[:sibling_id], parent: parent).first
          parent.destroy if parent.present?
        end
      end
      @siblings = student.siblings
    else
      sibling_ar = params[:sibling_olds].split(',').map{ |x| x.to_i }
      sibling_ar.delete(params[:sibling_id].to_i) if params[:sibling_id].present?
      @siblings = Student.where( id: sibling_ar )
    end
    respond_to do |format|
      format.js do
        @return_content = render_to_string(partial: 'students/list_student_sibling', locals: {siblings: @siblings})
      end
    end
  end
  
end
