module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {grade_id: params[:grade_id], :sort => column, :direction => direction, search: params[:search]}, {:class => css_class}
  end

  def sortable_attendance(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    if params[:attendance] && params[:attendance][:attendanced_at]
      link_to title, {utf8: "✓", attendance: {attendanced_at: params[:attendance][:attendanced_at]}, commit: "Check", :sort => column, :direction => direction}, {:class => css_class}
    else
      link_to title, {:sort => column, :direction => direction}, {:class => css_class}
    end
  end
end
