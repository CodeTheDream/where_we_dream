Rails.application.routes.draw do
  root 'pages#home'
  patch 'new_question_partial' => 'admin/questions#partial'
  get 'schools' => 'pages#schools'
  match 'schools', :via => :search, :to => 'admin/schools#search'

  namespace :admin do
    resources :schools
    resources :questions
  end

end
