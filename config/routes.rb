Rails.application.routes.draw do
  root 'home#index'
  resources :shipping_companies, only: [:index, :show, :new, :create, :edit, :update]
end
