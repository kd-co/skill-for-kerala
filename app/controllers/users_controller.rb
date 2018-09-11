class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:contact]

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
    begin
      @user = User.find_by_id(params[:id])
      authorize @user
      @user.contact!
    rescue ActiveRecord::RecordNotFound
      @error = "Record Not found"
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end
