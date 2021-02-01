class V1::UserController < ApplicationController
    before_action :authorized, only: [:me]

    #post auth/signup
    def signup
        user = User.new(params.permit(:login, :password, :email, :name))
        assert_save(user)
        token = JWT.encode({user_id: user[:id]}, Rails.configuration.salt)
        render json: {token: token}.merge(user.as_json), status: :ok
    end
    
    #post auth/signin
    def signin
        login = params[:login]
        password = params[:password]

        user = User.find_by login: login

        raise Err::Exceptions::UserNotFound unless user.present?
        if user.authenticate password
            token = JWT.encode({user_id: user[:id]}, Rails.configuration.salt)
            render json: {token: token}.merge(user.as_json), status: :ok        
        else
            raise Err::Exceptions::IncorrectPassword
        end
    end
    
    #post auth/signout
    # def signout
    # end


    #get user/me
    def me
        render json: @user, status: :ok
    end
end
