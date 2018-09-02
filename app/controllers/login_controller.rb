class LoginController < ApplicationController
  def oauth_callback
    print request.env.keys
    render json: {}
  end
end
