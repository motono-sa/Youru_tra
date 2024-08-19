Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root 'static_pages#top'
  resources :users, only: %i[new create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get 'search_limit_videos', to: 'videos#search_limit'
  resources :videos, only: %i[index show] do
    collection do
      get :search, to: 'videos#search', as: :search
    end
  end

  get 'mypage', to: 'users#show'
  get 'mypage/edit', to: 'users#edit'
  patch 'mypage', to: 'users#update'
  # 月ごとのカウントを表示する
  get 'mypage/:start_date', to: 'users#show', as: :mypage_date
  
  resources :users, only: %i[new create show edit update]
  resources :training_parts, only: %i[index]

  resources :password_resets, only: %i[new create edit update]
end
