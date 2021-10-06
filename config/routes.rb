Rails.application.routes.draw do
  get 'entries/create'
  get 'entries/update'
  get 'entries/destroy'
  resources :events
  devise_for :views
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
