Rails.application.routes.draw do
  root 'pages#home'

  get 'pages/home'
  get 'pages/schools'

  get 'schools' => 'pages#schools'
  match 'schools', :via => :search, :to => 'admin/schools#search'

  namespace :admin do
    resources :schools
    resources :questions
  end

end
