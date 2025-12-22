# app/services/dmt_customer_service.rb
module Eko
  class DmtCustomerService
    include HTTParty
    base_uri "https://staging.eko.in/ekoapi/v3"

    def self.check_profile(customer_id)
      headers = EkoAuthService.generate_headers

      get("/customer/profile/#{customer_id}", {
            query: {
              initiator_id: 9962981729,
              user_code: 20810200
            },
            headers: headers
      })
    end

    def self.create_customer(params)
      headers = EkoAuthService.generate_headers

      post("/customer/account", {
             body: params,
             headers: headers
      })
    end

    def self.verify_otp(params)
      headers = EkoAuthService.generate_headers

      put("/customer/account/otp/verify", {
            body: params,
            headers: headers
      })
    end
  end
end
