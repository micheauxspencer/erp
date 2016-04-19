class StudentParentsController < ApplicationController

  def create
    if params[:student_id].present?
      student = Student.find(params[:student_id])

      if student.present?
        parents = params[:parents].split(',')
        unless parents.empty?
          parents.each do |parent_id|
            parent = Parent.find(parent_id)
            if parent.present?
              StudentParent.find_or_create_by(student_id: student.id, parent_id: parent.id)

              siblings = parent.students
              unless siblings.empty?
                siblings.each do |sibling|
                  StudentSibling.find_or_create_by(student_id: student.id, sibling_id: sibling.id) unless student == sibling
                end
              end
            end
          end
        end
      end
      @parents = student.parents
    else
      parent_ar = params[:parents].split(',').map{ |x| x.to_i } + params[:parent_olds].split(',').map{ |x| x.to_i }
      @parents = Parent.where( id: parent_ar )
    end
    respond_to do |format|
      format.js do
        @return_content = render_to_string(partial: 'students/list_parents', locals: {parents: @parents})
      end
    end
  end

  def destroy
    if params[:student_id].present?
      student = Student.find(params[:student_id])
      parent = StudentParent.where(student_id: student.id, parent_id: params[:parent_id]).first
      parent.destroy if parent.present?
      # siblings = student.siblings
      # unless siblings.empty?
      #   siblings.each do |sibling|
      #     parent_sibling = StudentParent.where(student_id: sibling.id, parent_id: params[:parent_id]).first
      #     parent_sibling.destroy if parent_sibling.present?
      #   end
      # end
      @parents = student.parents
    else
      parent_ar = params[:parent_olds].split(',').map{ |x| x.to_i }
      parent_ar.delete(params[:parent_id].to_i) if params[:parent_id].present?
      @parents = Parent.where( id: parent_ar )
    end
    respond_to do |format|
      format.js do
        @return_content = render_to_string(partial: 'students/list_parents', locals: {parents: @parents})
      end
    end
  end

end
