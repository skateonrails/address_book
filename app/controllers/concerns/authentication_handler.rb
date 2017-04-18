module AuthenticationHandler
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
    attr_reader :current_user
  end

  def authenticate_request
    @current_user = AuthorizeUser.call(authorization_token).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def authorization_token
    return @authorization_token if @authorization_token.present?
    authorization_header = request.headers['Authorization'].to_s
    @authorization_token = authorization_header.split(' ').last
  end
end
