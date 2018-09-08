class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: 422
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end
