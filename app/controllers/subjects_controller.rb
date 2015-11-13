class SubjectsController < InheritedResources::Base

  private

    def subject_params
      params.require(:subject).permit(:name)
    end
end

