class StudentParentsController < ApplicationController

  def create
    student = Student.find(params[:student_id])

    if student.present?
      parents = params[:parents].split(',')
      unless parents.empty?
        parents.each do |parent|
          StudentParent.find_or_create_by(student_id: student.id, parent_id: parent.to_i)
          siblings = student.siblings
          unless siblings.empty?
            siblings.each do |sibling|
              StudentParent.find_or_create_by(student_id: sibling.id, parent_id: parent.to_i)
            end
          end
        end
      end
    end

    @parents = student.parents
    respond_to do |format|
      format.js do
        @return_content = render_to_string(partial: 'students/list_parents', locals: {parents: @parents})
      end
    end
  end

  def destroy
    student = Student.find(params[:student_id])
    parent = StudentParent.where(student_id: student.id, parent_id: params[:parent_id]).first
    parent.destroy if parent.present?
    siblings = student.siblings
    unless siblings.empty?
      siblings.each do |sibling|
        parent_sibling = StudentParent.where(student_id: sibling.id, parent_id: params[:parent_id]).first
        parent_sibling.destroy if parent_sibling.present?
      end
    end
    @parents = student.parents
    respond_to do |format|
      format.js do
        @return_content = render_to_string(partial: 'students/list_parents', locals: {parents: @parents})
      end
    end
  end

end
