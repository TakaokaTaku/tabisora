Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations',
  }
  root   'static_pages#home'
  get    '/home',    to: 'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'

  resources :users, only: [:show, :index]
  resources :trips
end
