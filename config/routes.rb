Rails.application.routes.draw do
  root 'pages#home'

  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
  post 'sessions/create'

  get 'comments/index'
  get 'comments/new'

  patch 'new_question_partial' => 'admin/questions#partial'
  get 'schools' => 'pages#schools'
  get 'profile' => 'pages#profile'
  # match 'schools', :via => :search, :to => 'pages#schools'

  resources :users, controller: 'admin/users'

  resources :schools, controller: 'admin/schools', only: :show do
    resources :comments
  end

  namespace :admin do
    resources :schools
    resources :questions
    resources :users
  end
end
