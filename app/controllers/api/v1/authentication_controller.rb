# frozen_string_literal: true

class Api::V1::AuthenticationController < Api::BaseController
  skip_before_action :authorize_request, only: %i[login refresh]

  def login
    puts "USER: " + auth_params[:email]
    puts "PASS: " + auth_params[:password]
    
    auth_token = Auth::AuthenticateUser.new(
      auth_params[:email],
      auth_params[:password]
    ).call

    user = User.find_by_email(auth_params[:email])
    refresh_token = Auth::GenerateRefreshToken.new(user).call


    tokens = {
      auth_token: auth_token,
      refresh_token: refresh_token
    }
    render json: tokens, status: :ok
  end

  def refresh
    token = params[:token]

    user = Auth::ValidateRefreshToken.new(token).call
    render(json: {}, status: :unauthorized) && return unless user

    auth_token = Auth::JsonWebToken.encode(user_id: user.id)
    refresh_token = Auth::GenerateRefreshToken.new(user).call

    tokens = {
      auth_token: auth_token,
      refresh_token: refresh_token
    }
    render json: tokens, status: :ok
  end

  private

  def auth_params
    params.permit(:email, :password)
  end

  def refresh_params
    params.permit(:token)
  end
end
