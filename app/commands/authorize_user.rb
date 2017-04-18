class AuthorizeUser
  prepend SimpleCommand

  def initialize(authentication_token)
    @authentication_token = authentication_token
  end

  def call
    unless decoded_authentication_token.present?
      errors.add(:token, 'Invalid token')
      return nil
    end

    user
  end

  private

  attr_reader :authentication_token

  def user
    @user ||= User.find(decoded_authentication_token[:user_id])
  end

  def decoded_authentication_token
    @decoded_authentication_token ||= JsonWebToken.decode(authentication_token)
  end
end
