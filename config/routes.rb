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

  get 'students' => 'pages#students'

  get 'about' => 'pages#about'
  get 'wait' => 'pages#wait'
  get 'contact' => 'pages#contact'
  get 'privacy' => 'pages#privacy'
  get 'FAQs' => 'pages#faqs'

  get 'activate' => 'admin/users#activate'

  delete 'comments/:id/delete' => 'comments#destroy' # Find a cleaner way to delete comments

  resources :schools do
    resources :comments, except: [:show, :update, :destroy]
  end

  resources :scholarships do
    resources :comments, except: [:show, :update, :destroy]
  end

  resources :states do
    resources :comments, except: [:show, :update, :destroy]
  end

  resources :stories do
    collection do
      patch 'preview'
    end
    resources :comments, except: [:show, :update, :destroy]
  end

  resources :users, controller: 'admin/users', only: [:new, :show, :update, :edit]

  namespace :admin do
    resources :questions, except: [:show, :edit]
    resources :users
    # resources :states
  end
end
