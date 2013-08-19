OurgoodsSplash::Application.routes.draw do
  root to: 'signups#new'
  get 'success', to: 'signups#success', as: 'success'

  resources :signups, only: [:new, :create]
end
