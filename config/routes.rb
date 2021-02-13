Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations',
  }
  root   'static_pages#home'
  get    '/home',    to: 'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/users',   to: 'application#back_root'
  get    '/trips',   to: 'application#back_root'
  get    '/memos',   to: 'application#back_root'

  resources :trips, expect: [:index] do
    member do
      patch :destroy_image
    end
  end
  resources :memos, only: [:new, :create, :destroy]
end
