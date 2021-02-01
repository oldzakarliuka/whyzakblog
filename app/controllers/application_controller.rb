class ApplicationController < ActionController::API
    rescue_from Exception do |err|

      if err.instance_of? Err::CustomException
        render json: {error: err.message}, status: err.status
      else
        puts "Error during processing: #{$!}"
        puts "Backtrace:\n\t#{err.backtrace.join("\n\t")}"
        render json: {error: err.message}, status: 500
      end
    end

    def assert_save(obj)
      raise Err::CustomException.new(obj.errors.full_messages, :unprocessable_entity) unless obj.save
    end

    def edit_object(object, excepts = [])
      excepts = ['id', 'created_at', 'updated_at'] | excepts
      toup = Hash.new
      request.params.each do |key, value|
        if object.respond_to?(key) || key == 'password'
          unless excepts.include?(key)
            if value != nil && value != {}
              toup[key] = value
            end
          end
        end
      end
      object.assign_attributes(toup)
      if object.valid?
        object.save
      else
        raise Err::CustomException.new(object.errors.full_messages, :unprocessable_entity)
      end
    end

    def auth_header
      # { Authorization: 'Bearer <token>' }
      request.headers['Authorization']
    end
  
    def decoded_token
      if auth_header
        token = auth_header.gsub('Bearer ', '')
        # header: { 'Authorization': 'Bearer <token>' }
        begin
          JWT.decode(token, Rails.configuration.salt, true, algorithm: 'HS256')
        rescue JWT::DecodeError
          nil
        end
      end
    end
  
    def logged_in_user
      if decoded_token
        user_id = decoded_token[0]['user_id']
        @user = User.find(user_id)
      end
    end
  
    def logged_in?
      !!logged_in_user
    end
  
    def authorized
      render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end
end
