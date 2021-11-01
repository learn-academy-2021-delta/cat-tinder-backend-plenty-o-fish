# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'http://localhost:3000/'  # <- change this to allow requests from any domain while in development.
  
      resource 'http://localhost:3000/',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
  end