class AngularProxy < Rack::Proxy
  def perform_request(env)
    request = Rack::Request.new(env)

    if request.path =~ %r{^/x}
      super(env)
    else
      @app.call(env)
    end
  end
end

Rails.application.config.middleware.use AngularProxy, backend: 'http://localhost:4200' if Rails.env.development?
