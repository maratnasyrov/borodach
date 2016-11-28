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

  get 'fill_schedule', to: 'work_days#fill_schedule'
  
  get 'now', to: 'days#show_current_date'
end
