Rails.application.routes.draw do
  namespace :v1 do
    controller :posts do
      get 'post', action: :all
      get 'post/:postId', action: :get_post
      post 'post/create', action: :create
      delete 'post/:postId', action: :delete
      post 'post/update', action: :update
    end

    controller :user do
      post 'auth/signin', action: :signin
      post 'auth/signup', action: :signup
      # post 'auth/signout', action: :signout

      get 'user/me', action: :me
    end
  end
  get '*', to: 'static#index'
  
end
