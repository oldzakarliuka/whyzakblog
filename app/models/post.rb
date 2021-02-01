class Post < ApplicationRecord
    belongs_to :user

    def as_json(options = {})
        obj = super
        obj[:user_name] = user[:name]
        obj[:user_login] = user[:login]
        obj.except("user_id")
    end
end
