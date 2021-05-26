Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      root 'hello#index'

      scope 'user' do
        get '/', to: 'users#index'
        post '/', to: 'users#create'
        delete '/', to: 'users#destroy'

        get '/followings', to: 'relationships#followings'
        post '/follow', to: 'relationships#follow'
        post '/unfollow', to: 'relationships#unfollow'
      end

      scope 'room' do
        get '/', to: 'rooms#index'
        post '/', to: 'rooms#create'
        get '/:id', to: 'rooms#join'
      end
    end
  end
end
