Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "finder#random"
      end
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index]
    end
  end
end
