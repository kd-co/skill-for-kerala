class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  respond_to :html, :json


  %w(facebook google_oauth2).each do |provider|
    define_method "#{provider}" do
      user = User.from_omniauth(request.env["omniauth.auth"])
      user.save()
      sign_in user if user.persisted?

      respond_to do |format|
        format.json { render json: user, status: user.persisted? ? 201 : 400 }
        format.html do
          if user.persisted?
            redirect_to root_path, event: :authentication
            set_flash_message(:notice, :success, kind: request.env['omniauth.auth']['provider']) if is_navigational_format?
          else
            session["devise.facebook_data"] = request.env["omniauth.auth"]
            redirect_to new_user_registration_url
          end
        end
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
