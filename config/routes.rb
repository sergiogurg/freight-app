Rails.application.routes.draw do
  devise_for :admins, path: 'admins', controllers: { sessions: 'admins/sessions', registrations: 'admins/registrations' }

  devise_for :users, path: 'users', controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  root to: 'home#index'

  resources :shipping_companies, only: [:index, :show, :new, :create, :edit, :update] do
    resources :vehicles, only: [:index, :new, :create, :edit, :update]
    resources :volume_prices, only: [:index, :new, :create]
    resources :weight_prices, only: [:index, :new, :create]
    resources :delivery_times, only: [:index, :new, :create]
    collection do
      get 'budget_form'
      get 'budget_search'
    end
  end

end
