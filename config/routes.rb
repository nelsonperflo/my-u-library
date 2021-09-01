Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root   'static_pages#home'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :books do
    patch 'checkout', on: :member
  end
  resources :borrowings do
    patch 'return', on: :member
  end
  resources :users
  resources :roles
end
