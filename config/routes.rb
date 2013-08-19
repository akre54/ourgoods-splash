OurgoodsSplash::Application.routes.draw do
  root to: 'signups#new'
  get 'signup', to: 'signups#new'
  post 'signup', to: 'signups#create'
end
