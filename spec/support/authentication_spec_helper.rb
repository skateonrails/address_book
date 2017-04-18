module AuthenticationSpecHelper
  def self.token(user)
    AuthenticateUser.call(email: user.email, password: user.password).result
  end

  def login_user_headers(user)
    { 'HTTP_AUTHORIZATION' => AuthenticationSpecHelper.token(user) }
  end

  def controller_login_user(user)
    request.env['HTTP_AUTHORIZATION'] = AuthenticationSpecHelper.token(user)
  end
end

RSpec.configure do |config|
  config.include AuthenticationSpecHelper, type: :controller
  config.include AuthenticationSpecHelper, type: :request
end
