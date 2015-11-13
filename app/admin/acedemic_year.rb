ActiveAdmin.register AcedemicYear do


  filter :year, as: :select
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
form do |f|
  f.inputs "Add/Edit Post" do
    f.input :year
    f.input :start_date
    f.input :end_date
    f.input :grades, :as => :check_boxes      
  end
  f.actions 
end
end
