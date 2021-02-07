Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: 'registrations',
  }
  root 'pages#index'
  get  'pages/show'
  resources :users, only: [:index, :show]
end
