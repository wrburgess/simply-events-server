Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  # root to: "static#home"

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :events
    end
  end
end
