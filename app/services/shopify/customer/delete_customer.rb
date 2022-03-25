# frozen_string_literal: true

module Shopify
  module Customer
    class DeleteCustomer
      def initialize(id)
        @id = id
      end

      def self.call(*args)
        new(*args).delete_customer
      end

      def delete_customer
        url = URI("https://#{shopify_store_name}.myshopify.com/admin/api/2022-01/graphql.json")
        variable = {
          "input":{
            "id": @id
            }
          }
        query = "mutation customerDelete($input: CustomerDeleteInput!) { customerDelete(input: $input) { deletedCustomerId, userErrors { field, message } } }"
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
