Rails.application.routes.draw do
  get 'users/index'
  get 'users/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      root 'hello#index'

      get '/user', to: 'users#index'
      post '/user', to: 'users#create'
      delete '/user', to: 'users#delete'
    end
  end
end
