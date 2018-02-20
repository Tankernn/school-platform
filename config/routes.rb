Rails.application.routes.draw do
  root 'sessions#new'

  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :conversations
  resources :conversation_participations
  resources :messages
  resources :schools
  resources :courses
  resources :course_participations
end
