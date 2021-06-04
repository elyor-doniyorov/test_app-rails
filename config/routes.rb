Rails.application.routes.draw do
  root 'users#index'
  resources :users
  get 'signup', to: 'users#new', as: 'signup'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
