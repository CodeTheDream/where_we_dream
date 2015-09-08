Rails.application.routes.draw do
  root 'pages#home'
  patch 'new_question_partial' => 'admin/questions#partial'
  # patch 'edi_questions' => 'admin/questions#update'
  get 'schools' => 'pages#schools'
  # match 'schools', :via => :search, :to => 'pages#schools'
  # get ':school_name'

  namespace :admin do
    resources :schools
    resources :questions
  end

end
