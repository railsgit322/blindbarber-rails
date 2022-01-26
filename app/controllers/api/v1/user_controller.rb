# frozen_string_literal: true

class Api::V1::UserController < Api::BaseController

  def index
    user = UserBlueprint.render @current_user
    render json: user, status: :ok
  end

  private



  def user_params
    params.require(:user).permit(
      :email, :password, :first_name, :last_name, :avatar
    )
  end
end
