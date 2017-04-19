class UsersController < ApplicationController

  def login
    command = AuthenticateUser.call(email: login_params[:email],
                                    password: login_params[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def create
    new_user.save!
    render json: new_user, status: :created
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def create_params
    params.require(:user).permit(:email, :password, organization_ids: [])
  end

  def new_user
    @user ||= User.new(create_params)
  end
end
