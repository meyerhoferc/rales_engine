Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "random#show"
        get 'most_revenue', to: "revenue#index"
        get ':id/favorite_customer', to: "customers#show"
        get ':id/customers_with_pending_invoices', to: "customers#index"
        get ':merchant_id/items', to: "items#index"
        get ':merchant_id/invoices', to: "invoices#index"
      end
      resources :merchants, only: [:index, :show]

      namespace :items do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "random#show"
        get '/:item_id/invoice_items', to: "invoice_items#index"
        get '/:item_id/merchant', to: "merchant#show"

      end
      get '/items/most_revenue', to: "items#most_revenue"
      resources :items, only: [:index, :show]

      namespace :customers do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "random#show"
        get ":id/invoices", to: "invoices#index"
        get ":id/transactions", to: "transactions#index"
      end
      resources :customers, only: [:index, :show]

      namespace :transactions do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "random#show"
        get ":id/invoice", to: "invoices#show"
      end

      resources :transactions, only: [:index, :show]

      namespace :invoices do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "random#show"
        get '/:invoice_id/transactions', to: "transactions#index"
        get '/:invoice_id/invoice_items', to: "invoice_items#index"
        get '/:invoice_id/items', to: "items#index"
        get '/:invoice_id/customer', to: "customer#index"
        get '/:invoice_id/merchant', to: "merchant#index"
      end
      resources :invoices, only: [:index, :show]

      namespace :invoice_items do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "random#show"
        get ':invoice_item_id/item', to: "item#show"
        get ':invoice_item_id/invoice', to: "invoice#show"
      end
      resources :invoice_items, only: [:index, :show]
    end
  end
end
