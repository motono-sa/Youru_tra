Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root 'static_pages#top'

  resources :videos, only: [] do
    collection do
      get :search, to: 'videos#search', as: :search
    end
  end
  resources :users, only:[:new, :create]
  resources :training_parts, only: [:index]
end
