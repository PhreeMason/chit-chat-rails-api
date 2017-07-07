Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
    	resources :users, only: [:create]
      post '/auth', to: 'auth#login'
      post 'auth/refresh', to: 'auth#refresh'
      resources :chatrooms, only: [:create, :index] do
        resource :chatroom_users
      end
    end
  end 

 

end
