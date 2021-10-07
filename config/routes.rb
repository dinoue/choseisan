Rails.application.routes.draw do
  get 'top', to: 'home#top', as: :top
  resources :events do
    resource :entry, controller: :event_entry, only: [:create, :update, :destroy]
  end
  devise_for :views
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
