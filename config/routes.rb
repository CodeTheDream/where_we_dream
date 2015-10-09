Rails.application.routes.draw do
  root 'pages#home'

  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
  post 'sessions/create'

  get 'comments/index'
  get 'comments/new'
  post 'opinions' => 'opinions#opinionate'

  get 'schools' => 'pages#schools'
  get 'profile' => 'pages#profile'
  get 'students' => 'pages#students'
  get 'about' => 'pages#about'
  get 'contact' => 'pages#contact'
  # match 'schools', :via => :search, :to => 'pages#schools'

  patch 'new_question_partial' => 'admin/questions#partial'

  resources :users, controller: 'admin/users', only: [:show, :update, :edit]
  resources :schools, controller: 'admin/schools', only: :show do
    resources :comments
  end
  namespace :admin do
    resources :schools
    resources :questions
    resources :users
  end
end
