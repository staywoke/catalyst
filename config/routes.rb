Rails.application.routes.draw do
  root to: 'dashboard#show'

  devise_for :users, controller: {sessions: 'users/sessions'}

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end

  get 'welcome', to: 'welcome#new', as: :welcome
  get 'welcome/:token', to: 'welcome#new'

  get 'account', to: 'users#edit', as: :account
  put 'account', to: 'users#update'
  post 'users', to: 'users#create', as: :users

  get 'dashboard', to: 'dashboard#show', as: :dashboard

  namespace :admin do
    get 'projects', to: 'projects#index', as: :projects
    get 'project/:key', to: 'projects#show', as: :project
    get 'project/:key/edit', to: 'projects#edit', as: :edit_project
    put 'project/:key', to: 'projects#update'
  end
end
