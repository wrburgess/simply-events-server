Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  root to: "static#home"

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      post "auth", to: "sessions#create"
      resources :events
      resources :favorites, except: [:update]
      resources :users
    end
  end
end
