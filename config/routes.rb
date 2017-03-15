Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "finder#random"
        get 'most_revenue', to: "revenue#index"
        get ':id/favorite_customer', to: "customer#show"
        get ':merchant_id/items', to: "items#index"
        get ':merchant_id/invoices', to: "invoices#index"
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
        get ":id/invoices", to: "invoices#index"
        get ":id/transactions", to: "transactions#index"
      end
      resources :customers, only: [:index, :show]

      namespace :transactions do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "finder#random"
      end

      resources :transactions, only: [:index, :show]

      namespace :invoices do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "finder#random"
      end
      resources :invoices, only: [:index, :show]

      namespace :invoice_items do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "finder#random"
      end
      resources :invoice_items, only: [:index, :show]
    end
  end
end
