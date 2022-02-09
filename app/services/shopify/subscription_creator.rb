# frozen_string_literal: true

module Shopify
  class SubscriptionCreator
    def initialize(subscription_params = {})
      @quantity = subscription_params[:quantity]
      @merchandiseId = subscription_params[:product_variant_id]
      @sellingPlanId = subscription_params[:selling_plan_id]
    end

    def self.call(*args)
      new(*args).create_subscription
    end

    def create_subscription
      url = URI("https://#{shopify_store_name}.myshopify.com/api/2022-01/graphql.json")
      query = "mutation cartCreateMutation($cartInput: CartInput) {cartCreate(input: $cartInput) { cart { id, checkoutUrl } } }"
      variables = {
          "cartInput" => {
              "lines" => [
                  {
                      "quantity" => @quantity.to_i,
                      "merchandiseId" => @merchandiseId,
                      "sellingPlanId"=> @sellingPlanId
                  }
              ]
          }
      }
      data = {
        "query" => query,
        "variables" => variables,
        "operationName" => "cartCreateMutation"
      }

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = 'application/json'
      request["X-Shopify-Storefront-Access-Token"] = shopify_storefront_access_token
      request.body = data.to_json
      response = http.request(request)
      response.read_body
    rescue
      OpenStruct.new({status: false})
    end

    def shopify_admin_access_token
      shopify_store_access = ShopifyStoreAccess.find_by(store_name: shopify_store_name+".myshopify.com")
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
