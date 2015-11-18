class ClassNamesController < ApplicationController
  before_filter :authenticate_user!
  def index
    return root_path unless current_user.role?(User::ROLE[:teacher])

    @class_names = ClassName.where(teacher_id: current_user.id)
  end
end