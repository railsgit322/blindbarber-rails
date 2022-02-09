# frozen_string_literal: true

class Api::V1::UsersController < Api::BaseController
  skip_before_action :authorize_request, only: %i[
    create forgot_password password_reset
  ]


  def index
    users = User.all.order('points desc')

    @users = Rails.cache.fetch users, expires_in: 10.minutes do
      UserBlueprint.render(users)
    end

    render json: @users, status: :ok
  end

  def create
    user = User.create!(user_params)
    
    puts "Params: " + user_params.inspect

    auth_token = Auth::AuthenticateUser.new(
      user_params[:email],
      user_params[:password]
    ).call

    render json: { auth_token: auth_token }, status: :created
  end

  def show
    user = User.find(params[:id])
    @user = UserBlueprint.render(user)
    render json: @user, status: :ok
  end

  def update
    if params[:avatar].present?
      avatar = params[:avatar]
      @current_user.remote_avatar_url = avatar
      @current_user.save
    else
      @current_user.update! user_params
    end
    if params[:delete_avatar].present? 
      puts "DELETE AVATAR"
      @current_user.remove_avatar!
      @current_user.save!
    end

    user_payload = UserBlueprint.render @current_user
    render json: user_payload, status: :ok
  end

  def forgot_password
    unless params[:email]
      return render json: { error: 'Email must be provided' },
                    status: :unprocessible_entity
    end

    user = User.find_by(email: params[:email])

    if user
      user.regenerate_reset_password_token
      link = users_verify_password_reset_url(token: user.reset_password_token)

      ::Mailers::ForgotPassword.new(user, link).call

      user.update_attribute(:reset_password_sent_at, DateTime.now.utc)
    end

    render json: {}, status: :ok
  end

  def password_reset
    ensure_password_matches

    user = User.find_by(reset_password_token: params[:token])

    unless user && ((user.reset_password_sent_at + 2.hours) > DateTime.now.utc)
      return render json: { error: 'Link invalid or expired. Please try again.' },
                    status: :unprocessable_entity
    end

    user.update(password: params[:password])

    auth_token = Auth::AuthenticateUser.new(
      user.email,
      user.password
    ).call

    render json: { auth_token: auth_token }, status: :ok
  end

  def show
    user = UserBlueprint.render @current_user
    render json: user, status: :ok
  end







  private

  def user_params
    params.require(:user).permit(
      :email, :password, :first_name, :last_name, :avatar, :phone
    )
  end

  def ensure_password_matches
    if params[:password] != params[:confirm_password]
      raise ::Pickup::Exceptions::PasswordMismatch
    end
  end
end
