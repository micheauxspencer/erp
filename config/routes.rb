Rails.application.routes.draw do

  devise_for :admin_user

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root :to => "students#index"

  # resources :teachers

  devise_for :users

  get 'profile' => 'users#profile', as: :profile
  patch 'users/update_profile' => 'users#update_profile', as: :update_profile
  get 'teacher/:user_id' => 'users#show_teacher', as: :show_teacher
  patch 'users/:user_id/update_teacher' => 'users#update_teacher', as: :update_teacher
  get 'users/export_staff' => 'users#export_staff', as: :export_staff
  get 'users/export_attendance' => "users#export_attendance", as: :export_attendance_users
  get 'teachers' => 'users#teachers', as: :teachers

  resources :acedemic_years

  resources :fee_categories
  resources :routes

  resources :fees

  get 'fees/report_paid/:student_id' => "fees#report_paid", as: :fee_report_paid
  get 'fees/report_unpaid/:student_id' => "fees#report_unpaid", as: :fee_report_unpaid
  get 'fees/report_by_family/:student_id' => "fees#report_by_family", as: :fee_report_by_family
  resources :terms

  resources :models

  resources :grades do
    collection do
      get 'enter_grade' => "grades#enter_grade", as: :enter_grade
      get 'export_students/:id' => "grades#export_students", as: :export_students
      get 'export_all' => "grades#export_all", as: :export_all
      get ':id/export_attendance' => "grades#export_attendance", as: :export_attendance
      post 'add_template'
    end
  end

  resources :students

  resource :attendances


  get '/grades/:grade_id/student_attendance' => "attendances#student_attendance", as: :grade_student_attendance
  get '/grades/:grade_id/teacher_attendance' => "attendances#teacher_attendance", as: :grade_teacher_attendance
  get '/attendances/teacher_attendance_all' => "attendances#teacher_attendance_all", as: :teacher_attendance_all

  get '/attendances/export_by_student' => "attendances#export_by_student", as: :attendance_export_by_student, defaults: { format: 'xls' }
  get '/attendances/export_by_grade' => "attendances#export_by_grade", as: :attendance_export_by_grade, defaults: { format: 'xls' }
  get '/attendances/export_by_staff' => "attendances#export_by_staff", as: :attendance_export_by_staff, defaults: { format: 'xls' }

  get '/classes' => 'class_names#index', as: :class_list

  get '/term_snapshot' => 'students#term_snapshot', as: :view_snapshot_term

  get 'set_current_term' => "terms#set_current_term", as: :set_current_term
  get 'set_current_acedemic_year' => "acedemic_years#set_current_acedemic_year", as: :set_current_acedemic_year

  post 'students/assign_fee' => "students#assign_fee", as: :assign_fee
  post 'students/:student_id/routes' => "students#assign_route", as: :assign_route

  post 'students/:student_id/payment' => "students#payment", as: :student_fee

  get 'students/export_pdf/:student_id' => "students#export_pdf", as: :export_pdf
  get 'students/export_fee/:student_id' => "students#export_fee", as: :export_fee
  get 'export_students' => "students#export_all", as: :student_export_all

  get 'students/:student_id/enter_mark' => "students#enter_mark", as: :enter_mark
  post 'students/save_mark' => "students#save_mark", as: :save_mark
  get 'students/:id/curricular' => "students#curricular", as: :curricular
  post 'students/save_curricular' => "students#save_curricular", as: :save_curricular
  get 'students/:student_id/select_term' => "students#select_term", as: :select_term
  post 'students/:student_id/enroll' => "students#enroll", as: :enroll_student
  get 'students/:id/export_attendance' => "students#export_attendance", as: :export_attendance_students
  
  post 'save_import_student' => "students#save_import_student", as: :save_import_student
  get 'import_student' => "students#import", as: :import_student
  post 'students/delete_all' => "students#delete_all", as: :delete_all_student

  get 'expprt_health' => "students#expprt_health", as: :expprt_health

  get 'students/family_report/:id' => "students#family_report", as: :student_family_report
  get 'students/families_report/:id' => "students#families_report", as: :student_families_report

  post 'student_siblings/create' => "student_siblings#create", as: :create_sibling
  post 'student_siblings/delete' => "student_siblings#destroy", as: :delete_sibling

  post 'student_parents/create' => "student_parents#create", as: :create_parent
  post 'student_parents/delete' => "student_parents#destroy", as: :delete_parent

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
