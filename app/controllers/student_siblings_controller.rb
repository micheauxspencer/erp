class StudentSiblingsController < ApplicationController
  def create
    
  end

  def destroy
    
  end

  private
    def student_sibling_params
      params.require(:student_sibling).permit(:student_id, :sibling_id)
    end
end
