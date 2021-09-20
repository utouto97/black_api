Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      scope 'user' do
        get '/', to: 'users#index'
        post '/', to: 'users#create'
        patch '/', to: 'users#update'

        scope 'room' do
          get '/', to: 'room_users#index'
          post '/:room_id', to: 'room_users#create'
          delete '/:room_id', to: 'room_users#destroy'
        end
      end

      scope 'room' do
        get '/', to: 'rooms#index'
        post '/', to: 'rooms#create'
        patch '/:room_id', to: 'rooms#update'
        delete '/:room_id', to: 'rooms#destroy'

        scope 'message' do
          get '/', to: 'messages#index'
          post '/', to: 'messages#create'
        end
      end
    end
  end
end
