Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'accounts', controller: 'accounts', action: 'index'
  get 'accounts/:number', controller: 'accounts', action: 'show'
  get 'account_transfers', controller: 'account_transfers', action: 'index'
  get 'account_transactions', controller: 'account_transactions', action: 'index'


  post 'accounts', controller: 'accounts', action: 'create'
  post 'account_transfers', controller: 'account_transfers', action: 'create'
  post 'account_transactions', controller: 'account_transactions', action: 'create'
  post 'login_sessions', controller: 'login_sessions', action: 'create'
  post 'users', controller: 'users', action: 'create'
end
