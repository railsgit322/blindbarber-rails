# frozen_string_literal: true

module Shopify
  class StorefrontAccessTokenCreator
    def initialize(admin_access_token)
      @admin_access_token = admin_access_token
    end

    def self.call(*args)
      new(*args).get_storefront_access_token
    end

    def get_storefront_access_token
      url = URI("https://#{shopify_store_name}.myshopify.com/admin/api/2022-01/storefront_access_tokens.json")
      random_string = (0...10).map { (65 + rand(26)).chr }.join
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      data = {
        "storefront_access_token" => {
          "title" => "Blindbarber_"+random_string
        }
      }
      request = Net::HTTP::Post.new(url)
      request["cookie"] = 'request_method=POST'
      request["Content-Type"] = 'application/json'
      request["X-Shopify-Access-Token"] = @admin_access_token
      request.body = data.to_json

      response = http.request(request)
      response = JSON.parse response.read_body
      
      response["storefront_access_token"]
    rescue
      {"access_token": nil}
    end

    def shopify_admin_access_token
      ENV['SHOPIFY_ADMIN_ACCESS_TOKEN']
    end

    def shopify_storefront_access_token
      ENV['SHOPIFY_STOREFRONT_ACCESS_TOKEN']
    end

    def shopify_api_key
      ENV['SHOPIFY_API_KEY']
    end

    def shopify_api_secret_key
      ENV['SHOPIFY_SECRET_KEY']
    end

    def shopify_store_name
      ENV['SHOPIFY_STORE_NAME']
    end
  end
end
