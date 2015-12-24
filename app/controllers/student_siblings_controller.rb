class StudentSiblingsController < ApplicationController
  def create
    student = Student.find(params[:student_id])

    if student.present?
      siblings = params[:siblings].split(',')
      unless siblings.empty?
        siblings.each do |sibling|
          StudentSibling.find_or_create_by(student_id: student.id, sibling_id: sibling.to_i)
        end
      end
    end
    @siblings = student.siblings
    respond_to do |format|
      format.js do
        @return_content = render_to_string(partial: 'students/list_student_sibling', locals: {siblings: @siblings})
      end
    end
  end

  def destroy
    student = Student.find(params[:student_id])
    sibling = StudentSibling.where(student_id: student.id, sibling_id: params[:sibling_id]).first
    sibling.destroy if sibling.present?
    @siblings = student.siblings
    respond_to do |format|
      format.js do
        @return_content = render_to_string(partial: 'students/list_student_sibling', locals: {siblings: @siblings})
      end
    end
  end

  private
    def student_sibling_params
      params.require(:student_sibling).permit(:student_id, :sibling_id)
    end
end
