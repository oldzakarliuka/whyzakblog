class Err::CustomException < StandardError
  attr_accessor :status

  def initialize(msg="", code=500)
    super(msg)
    @status = code
  end
end