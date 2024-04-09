require 'sidekiq/web'

Rails.application.routes.draw do
  root 'welcome#index'
  #mount Sidekiq::Web => '/sidekiq'
  resources :certificates
  get '/.well-known/acme-challenge/:verification_path', to: 'verifications#show'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
   username == 'admin' && password == 'imsny123#'
  end if Rails.env.production?
  mount Sidekiq::Web => '/sidekiq'
end
