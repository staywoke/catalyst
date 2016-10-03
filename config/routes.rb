Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  get 'welcome', to: 'welcome#new', as: :welcome
  get 'welcome/:token', to: 'welcome#new'

  post 'users', to: 'users#create', as: :users

  get 'dashboard', to: 'dashboard#show', as: :dashboard
end
