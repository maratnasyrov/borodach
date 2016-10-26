Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root to: "pages#home"

  resources :years do
    resources :months
  end

  resources :months do
    resources :days
  end
end
