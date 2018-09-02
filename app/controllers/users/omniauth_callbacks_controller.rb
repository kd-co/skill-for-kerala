class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  respond_to :html, :json

  def facebook
    user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in user if user.persisted?

    respond_to do |format|
      format.json { render json: user }
    end
  end

  def failure
    redirect_to root_path
  end
end
