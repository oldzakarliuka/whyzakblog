class User < ApplicationRecord
    has_many :post
    has_secure_password
    validates :login, presence: true, uniqueness: { case_sensitive: true}, length: {minimum: 3, maximum: 50}

    def as_json(options = {})
        obj = super
        obj.except("password_digest")
    end
end
