Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
      end
      resources :merchants, only: [:index, :show]
    end
  end
end
