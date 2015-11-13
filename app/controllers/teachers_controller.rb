class TeachersController < InheritedResources::Base

  private

    def teacher_params
      params.require(:teacher).permit()
    end
end

