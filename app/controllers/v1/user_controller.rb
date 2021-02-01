class V1::UserController < ApplicationController
    #post auth/signup
    def signup
        
    end
    
    #post auth/signin
    def signin
    end
    
    #post auth/signout
    def signout
    end


    #get user/me
    def me
        render json: {h: "hello world"}
    end
end
