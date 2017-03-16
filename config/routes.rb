Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "random#show"
        get 'most_revenue', to: "revenue#index"
        get 'revenue', to: "revenue#date"
        get 'most_items', to: "items#number_of_items_sold"
      end

      resources :merchants, only: [:index, :show] do
        get 'favorite_customer', to: "merchants/customers#show"
        get 'customers_with_pending_invoices', to: "merchants/customers#index"
        get 'items', to: "merchants/items#index"
        get 'invoices', to: "merchants/invoices#index"
        get 'revenue', to: "merchants/revenue#total_revenue_per_merchant"
      end

      namespace :items do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "random#show"
        get 'most_revenue', to: "revenue#index"
        get 'most_items', to: "items#most_items"
      end

      resources :items, only: [:index, :show] do
        get 'invoice_items', to: "items/invoice_items#index"
        get 'merchant', to: "items/merchant#show"
      end

      namespace :customers do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "random#show"
      end

      resources :customers, only: [:index, :show] do
        get "invoices", to: "customers/invoices#index"
        get "transactions", to: "customers/transactions#index"
        get "favorite_merchant", to: "customers/merchant#show"
      end

      namespace :transactions do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "random#show"
      end

      resources :transactions, only: [:index, :show] do
        get "invoice", to: "transactions/invoices#show"
      end

      namespace :invoices do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "random#show"
      end

      resources :invoices, only: [:index, :show] do
        get 'transactions', to: "invoices/transactions#index"
        get 'invoice_items', to: "invoices/invoice_items#index"
        get 'items', to: "invoices/items#index"
        get 'customer', to: "invoices/customer#index"
        get 'merchant', to: "invoices/merchant#show"
      end

      namespace :invoice_items do
        get 'find', to: "finder#show"
        get 'find_all', to: "finder#index"
        get 'random', to: "random#show"
      end

      resources :invoice_items, only: [:index, :show] do
        get 'item', to: "invoice_items/item#show"
        get 'invoice', to: "invoice_items/invoice#show"
      end
    end
  end
end
