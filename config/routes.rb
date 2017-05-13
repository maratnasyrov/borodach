Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root to: "pages#index"

  resources :users
  
  resources :years do
    resources :months
  end

  resources :months do
    resources :days
  end

  resources :masters
  resources :work_days

  resources :days do
    resources :work_days
  end

  resources :work_days do
    resources :records
  end

  resources :services

  resources :masters do
    resources :services
  end

  resources :purchases

  resources :records do
    resources :record_purchases
  end

  resources :records do
    resources :record_services
  end

  resources :purchases do
    resources :purchase_histories
  end

  resources :masters do
    resources :finances
  end

  resources :days do
    resources :finance_days
  end

  resources :days do
    resources :pre_records
  end

  resources :records do
    resources :pre_records
  end

  resources :records do
    resources :record_shelves
  end

  resources :finances

  resources :costs

  resources :shelves

  resources :days do
    resources :shelf_histories
  end

  resources :brands do
    resources :purchases
  end

  resources :providers
  
  resources :providers do
    resources :brands
  end

  resources :brands

  resources :brands do
    resources :categories 
  end

  resources :salons

  resources :clients

  resources :client_histories

  resources :orders

  resources :orders do
    resources :product_lists 
  end

  resources :landing_images
  
  resources :working_shifts

  match 'open_record/:id', to: 'records#open_record', as: :open_record, via: [:get, :post]
  match 'clear_record/:id', to: 'records#clear_record', as: :record_clear, via: [:get, :post]
  match 'closed_record/:id', to: 'records#closed_record', as: :closed_record, via: [:get, :post]
  match 'status_online/:id', to: 'records#status_online', as: :status_online, via: [:get, :post]
  match 'change_payment_type/:id', to: 'records#change_payment_type', as: :change_payment_type, via: [:get, :post]
  match 'add_shelf/:id', to: 'shelves#add_shelf', as: :add_shelf, via: [:get, :post]
  match 'close_order/:id', to: 'orders#close', as: :close, via: [:get, :post]
  match 'add_to_stock/:id', to: 'product_lists#add_to_stock', as: :add_to_stock, via: [:get, :post]
  match 'set_dinner/:id', to: 'records#set_dinner', as: :set_dinner, via: [:get, :post]

  get 'fill_schedule', to: 'months#fill_schedule'

  get 'success', to: 'pages#success_online'
  
  get 'now', to: 'days#show_current_date'
  get 'finance_now', to: 'finance_days#show_current_finance_day'
  get 'show_settings', to: 'application#show_settings'
end
