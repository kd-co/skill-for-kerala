class ApplicationController < ActionController::Base
  def static
    render 'layouts/angular'
  end
end
