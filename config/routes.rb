Rails.application.routes.draw do
  get '/sheets', to: "sheets#index"
  post "/reservation", to: "reservations#create"

  resources :movies do
    member do
      # 記法
      get "reservation", to: "movies#reservation"

    end
    resources :schedules do
      resources :reservations, only: [:new]
    end
  end

  namespace :admin do
    # admin::moviesだから
    resources :movies do
      resources :schedules, only: [:edit, :destroy, :update]

    end
    resources :reservations # namespaceでネストされてるからadmin::reservations_controllerだよ
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
