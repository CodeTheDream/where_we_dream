Rails.application.routes.draw do
  get 'comments/index'

  get 'comments/new'

  root 'pages#home'

  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
  post 'sessions/create'

  patch 'new_question_partial' => 'admin/questions#partial'
  get 'schools' => 'pages#schools'
  # match 'schools', :via => :search, :to => 'pages#schools'
  resources :schools, controller: 'admin/schools', only: :show do
    resources :comments
  end
  namespace :admin do
    resources :schools
    resources :questions
    resources :users, except: :show
  end
end
