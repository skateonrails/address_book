class UsersController < ApplicationController

  def login
    command = AuthenticateUser.call(command_params)

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  private

  def authentication_params
    params.permit(:email, :password)
  end

  def command_params
    {
      email: authentication_params[:email],
      password: authentication_params[:password]
    }
  end
end
