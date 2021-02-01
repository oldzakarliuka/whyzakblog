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
end
