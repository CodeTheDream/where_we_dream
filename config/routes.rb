Rails.application.routes.draw do
  root 'pages#home'

  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
  post 'sessions/create'

  patch 'new_question_partial' => 'admin/questions#partial'
  get 'schools' => 'pages#schools'
  # match 'schools', :via => :search, :to => 'pages#schools'

  resources :users

  namespace :admin do
    resources :schools
    resources :questions
  end

end
