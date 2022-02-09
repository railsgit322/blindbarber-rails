# frozen_string_literal: true

module Shopify
  class AdminAccessTokenCreator
    def initialize(code)
      @code = code
    end

    def self.call(*args)
      new(*args).get_admin_access_token
    end

    def get_admin_access_token
      data = {
        "client_id" => shopify_api_key,
        "client_secret" => shopify_api_secret_key,
        "code" => @code
      }

      url = URI("https://#{shopify_store_name}.myshopify.com/admin/oauth/access_token")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(url)
      request["cookie"] = 'request_method=POST'
      request["Content-Type"] = 'application/json'
      request["X-Shopify-Access-Token"] = shopify_admin_access_token
      request.body = data.to_json

      response = http.request(request)
      response = JSON.parse response.read_body
      response
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
