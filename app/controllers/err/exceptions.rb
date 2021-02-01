class Err::Exceptions
  NoToken = Err::CustomException.new("Token is absent", 400)
  InvalidToken = Err::CustomException.new("Token is invalid", 401)

  UserNotFound = Err::CustomException.new("User is not found", 404)
  IncorrectPassword = Err::CustomException.new("Password is incorrect", 401)

  VerifyFailed = Err::CustomException.new("Verify failed", 401)
end
