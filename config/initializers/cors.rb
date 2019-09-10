Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Until we know what domains we need to whitelist
    origins '*'
    resource '*', :headers => :any, :methods => :any
   end
end
