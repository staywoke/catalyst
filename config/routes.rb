Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, controller: {sessions: 'users/sessions'}

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end

  get 'welcome', to: 'welcome#new', as: :welcome
  get 'welcome/:token', to: 'welcome#new'

  post 'users', to: 'users#create', as: :users

  get 'dashboard', to: 'dashboard#show', as: :dashboard
end
