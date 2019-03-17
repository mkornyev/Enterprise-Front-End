Rails.application.routes.draw do
  #Root to website home
  root 'home#index'
  
  #Basic page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy

  resources :customers 
  resources :addresses
  resources :orders
end
