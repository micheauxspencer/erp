Rails.application.routes.draw do

  devise_for :admin_user

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root :to => "students#index"

  resources :teachers

  devise_for :users

  resources :acedemic_years

  resources :fee_categories
  resources :routes

  resources :fees

  resources :terms

  resources :models

  resources :grades do
    collection do
      get 'enter_grade' => "grades#enter_grade", as: :enter_grade
      post 'add_template'
    end
  end

  resources :students

  resource :attendances


  get '/grades/:grade_id/attendance' => "attendances#index", as: :grade_attendance

  get '/classes' => 'class_names#index', as: :class_list

  get '/term_snapshot' => 'students#term_snapshot', as: :view_snapshot_term

  get 'set_current_term' => "terms#set_current_term", as: :set_current_term

  post 'students/assign_fee' => "students#assign_fee", as: :assign_fee
  post 'students/:student_id/routes' => "students#assign_route", as: :assign_route

  post 'students/:student_id/payment' => "students#payment", as: :student_fee

  get 'students/export_pdf/:student_id' => "students#export_pdf", as: :export_pdf

  get 'students/:student_id/enter_mark' => "students#enter_mark", as: :enter_mark
  post 'students/save_mark' => "students#save_mark", as: :save_mark
  get 'students/:student_id/select_term' => "students#select_term", as: :select_term

  post 'student_siblings/create' => "student_siblings#create", as: :create_sibling
  post 'student_siblings/delete' => "student_siblings#destroy", as: :delete_sibling

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
