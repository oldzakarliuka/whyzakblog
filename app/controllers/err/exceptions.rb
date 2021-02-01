class Err::Exceptions
  NoToken = Err::CustomException.new("Token is absent", 	:bad_request)
  InvalidToken = Err::CustomException.new("Token is invalid", :unauthorized)

  UserNotFound = Err::CustomException.new("User is not found", 404)
  IncorrectPassword = Err::CustomException.new("Password is incorrect", :unauthorized)

  VerifyFailed = Err::CustomException.new("Verify failed", :unauthorized)

  DeletePostOtherUser = Err::CustomException.new("Post can be deleted only by creator", :forbidden)

  UpdPostOtherUser = Err::CustomException.new("Post can be updated only by creator", :forbidden)
end
