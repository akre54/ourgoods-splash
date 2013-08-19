OurgoodsSplash::Application.routes.draw do
  root to: 'signups#new'

  resources :signups, only: [:new, :create]
end
