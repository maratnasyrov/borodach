Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root to: "pages#home"

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
    resources :finances
  end

  match 'clear_record/:id', to: 'records#clear_record', as: :record_clear, via: [:get, :post]
  match 'closed_record/:id', to: 'records#closed_record', as: :closed_record, via: [:get, :post]

  get 'fill_schedule', to: 'months#fill_schedule'
  
  get 'now', to: 'days#show_current_date'
  get 'finance_now', to: 'finances#show_current_finance_day'
end
