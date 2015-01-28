OurgoodsSplash::Application.routes.draw do
  root to: 'signups#new'
  get 'success', to: 'signups#success', as: 'success'

  get 'spreadsheet', to: 'signups#spreadsheet', as: 'spreadsheet'

  resources :signups, only: [:new, :create]

  resources :charges, only: [:new, :create]
end
