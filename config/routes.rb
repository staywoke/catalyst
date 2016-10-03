Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  get 'welcome', to: 'welcome#new', as: :welcome
  get 'welcome/:token', to: 'welcome#new'

  post 'users', to: 'users#create', as: :users

  get 'dashboard', to: 'dashboard#show', as: :dashboard
end
