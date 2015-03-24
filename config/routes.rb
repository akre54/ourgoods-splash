OurgoodsSplash::Application.routes.draw do
  root to: 'signups#new'
  get 'success', to: 'signups#success', as: 'success'

  get 'spreadsheet', to: 'signups#spreadsheet', as: 'spreadsheet'

  resources :signups, only: [:new, :create]
  resources :charges, only: [:new, :create]

  # We're reusing the signup resource in our charges controller. Just redirect
  # them to Charges#create
  match 'charges', to: 'charges#create', via: [:put, :patch]
end
