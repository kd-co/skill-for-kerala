class ApplicationController < ActionController::Base
  def static
    render html: "hello", layout: true
  end
end
