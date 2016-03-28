Rails.application.routes.draw do
  root 'pages#home'

  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
  post 'sessions/create'

  # omniauth routes
  match 'auth/:provider/callback', via: [:get, :post], to: 'sessions#omniauth'

  get 'comments/index'
  get 'comments/new'
  post 'opinions' => 'opinions#opinionate'

  get 'schools' => 'pages#schools'
  get 'students' => 'pages#students'
  get 'about' => 'pages#about'
  get 'wait' => 'pages#wait'
  get 'contact' => 'pages#contact'
  get 'scholarships' => 'pages#scholarships'
  get 'FAQs' => 'pages#faqs'
  # match 'schools', :via => :search, :to => 'pages#schools'

  get 'activate' => 'admin/users#activate'

  delete 'comments/:id/delete' => 'comments#destroy'

  resources :schools, controller: 'admin/schools', only: :show do
    resources :comments, except: [:show, :update, :destroy]
  end

  resources :scholarships, controller: 'admin/scholarships', only: [:show, :delete] do
    resources :comments, except: [:show, :update, :destroy]
  end

  get "states/data" => "admin/states#data"
  resources :states, controller: 'admin/states', only: [:index, :show] do
    resources :comments, except: [:show, :update, :destroy]
  end

  resources :stories do
    resources :comments, except: [:show, :update, :destroy]
  end

  resources :users, controller: 'admin/users', only: [:new, :show, :update, :edit]

  namespace :admin do
    resources :schools
    resources :questions, except: [:show, :edit]
    resources :users
    resources :scholarships
    resources :states
  end
end
