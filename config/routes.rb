Rails.application.routes.draw do
  get 'feeds/index'
  get 'feeds/show'
  root 'home#index'
  get '/feeds',     to: 'feeds#index'
  get '/new_feed',  to: 'feeds#new'
  post '/new_feed', to: 'feeds#create'
  get '/feeds/*',   to: 'feeds#show'
  
  resources :feeds
end
