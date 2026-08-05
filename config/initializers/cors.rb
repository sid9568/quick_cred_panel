Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'  # 👈 You can restrict this later (e.g., 'http://localhost:3000')

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Authorization']  # 👈 If using JWT or API tokens
  end
end
