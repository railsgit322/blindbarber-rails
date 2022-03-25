# frozen_string_literal: true

module Shopify
  module Customer
    class CreateCustomer
      def initialize(customer_params)
        @firstName = customer_params[:firstName]
        @lastName = customer_params[:lastName]
        @email = customer_params[:email]
      end

      def self.call(*args)
        new(*args).create_customer
      end

      def create_customer
        url = URI("https://#{shopify_store_name}.myshopify.com/admin/api/2022-01/graphql.json")
          variable ={
            "input": {
              "email": @email,
              "firstName": @firstName,
              "lastName": @lastName
            }
            }
          query = "mutation customerCreate($input: CustomerInput!) {
            customerCreate(input: $input) {
              userErrors { 
                field 
                message 
              }
              customer {
                id
                email
                firstName
                lastName
              }
            }
          }"
         
          data = {
            "query" => query,
            "variables" => variable
          }
          http = Net::HTTP.new(url.host, url.port)
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  
          request = Net::HTTP::Post.new(url)
          request["cookie"] = 'request_method=POST'
          request["Content-Type"] = 'application/json'
          request["X-Shopify-Access-Token"] = ENV['SHOPIFY_ADMIN_ACCESS_TOKEN']
          request.body = data.to_json
          response = http.request(request)
          response.read_body
      rescue
        OpenStruct.new({status: false})
      end

      def shopify_admin_access_token
        shopify_store_access = ShopifyStoreAccess.find_by(store_name: shopify_store_name+".myshopify.com")
        puts shopify_store_access.inspect
        shopify_store_access.admin_access_token
      end

      def shopify_storefront_access_token
        shopify_store_access = ShopifyStoreAccess.find_by(store_name: shopify_store_name+".myshopify.com")
        shopify_store_access.storefront_access_token
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
end
