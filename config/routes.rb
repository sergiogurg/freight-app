Rails.application.routes.draw do
  devise_for :admins, path: 'admins', controllers: { sessions: 'admins/sessions', registrations: 'admins/registrations' }
  devise_for :users, path: 'users', controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  root to: 'home#index'
  resources :shipping_companies, only: [:index, :show, :new, :create, :edit, :update] do
    resources :vehicles, only: [:index, :show, :new, :create, :edit, :update]
  end
end
