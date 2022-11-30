Rails.application.routes.draw do
  
  resources :enrollments do
    get :my_students, on: :collection
  end
  devise_for :users
  resources :courses do
    get :enrolled, :pending_review, :created, on: :collection
    resources :enrollments, only: [:new, :create]
    resources :lessons
  end
  
  resources :users, only: [:index, :edit, :show, :update]
  root 'static_pages#landing_page'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'activity', to: 'static_pages#activity'
  get 'index_user', to: 'enrollments#index_user'

  mount Rapidfire::Engine => "/rapidfire"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
