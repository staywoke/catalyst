Rails.application.routes.draw do
  root to: 'static#home'

  devise_for :users, controller: {sessions: 'users/sessions'}

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end

  get 'welcome', to: 'welcome#new', as: :welcome
  get 'welcome/:token', to: 'welcome#new'

  get 'account', to: 'users#edit', as: :account
  put 'account', to: 'users#update'
  post 'users', to: 'users#create', as: :users

  get 'actions', to: 'tasks#index', as: :tasks
  get 'actions/:token', to: 'tasks#show', as: :task
  post 'actions/:token', to: 'responses#create', as: :response

  namespace :admin do
    get 'projects', to: 'projects#index', as: :projects
    get 'projects/:key/edit', to: 'projects#edit', as: :edit_project
    put 'projects/:key', to: 'projects#update', as: :project

    get 'responses', to: 'responses#index', as: :responses
    get 'responses/:token', to: 'responses#show', as: :response
    put 'responses/:token', to: 'responses#update'

    resources 'cities'
    resources 'domains', except: :show
    resources 'users', only: 'index'
  end
end
