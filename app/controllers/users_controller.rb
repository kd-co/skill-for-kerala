class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: 422
    end
  end

  api :PUT, '/users/:id/contact'
  param :id, :number, required: true
  def contact
    @user = User.find_by_id(params[:id])
    authorize @user
    @user.contact!
  rescue ActiveRecord::RecordNotFound
    @error = 'Record Not found'
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end
