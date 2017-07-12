Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
    	resources :users, only: [:create]
      post '/auth', to: 'auth#login'
      post 'auth/refresh', to: 'auth#refresh'
      resources :chatrooms do
        resource :chatroom_users, only: [:create, :destroy]
        resources :messages, only: [:create]
      end
    end
  end 

 

end
