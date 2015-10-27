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
  get 'wait' => 'pages#wait'
  get 'contact' => 'pages#contact'
  get 'scholarships' => 'pages#scholarships'
  # match 'schools', :via => :search, :to => 'pages#schools'

  patch 'new_question_partial' => 'admin/questions#partial'

  get 'activate' => 'admin/users#activate'

  delete 'comments/:id/delete' => 'comments#destroy'

  resources :users, controller: 'admin/users', only: [:new, :show, :update, :edit]

  resources :scholarships, controller: 'admin/scholarships', only: [:show, :delete] do
    resources :comments
  end

  resources :schools, controller: 'admin/schools', only: :show do
    resources :comments
  end

  namespace :admin do
    resources :schools
    resources :questions
    resources :users
    resources :scholarships
  end
end
