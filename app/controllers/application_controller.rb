class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    render json: {
      status: 200,
      error: 'Not authorized to do this action',
      policy: policy_name
    }
  end

  def authenticate_admin_user!
    authenticate_user!
    raise unless current_user.super_admin?
  end
end
