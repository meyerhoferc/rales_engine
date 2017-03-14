Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "finder#random"
      end
      resources :merchants, only: [:index, :show]

      namespace :items do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "finder#random"
      end
      resources :items, only: [:index, :show]

      namespace :customers do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "finder#random"
      end
      resources :customers, only: [:index, :show]

      resources :invoices, only: [:index, :show]
    end
  end
end
