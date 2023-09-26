Rails.application.routes.draw do

  namespace :api do
    namespace :v0 do
      resources :forecast, only: [:index]
      get '/munchies', to: 'munchie#show'
    end
  end

end
