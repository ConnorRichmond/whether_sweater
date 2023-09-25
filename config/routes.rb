Rails.application.routes.draw do

  namespace :api do
    namespace :v0 do
      resources :forecast, only: [:index]
      get 'book-search', to: 'book_search#index'
    end
  end

end
