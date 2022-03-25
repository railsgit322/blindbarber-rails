# frozen_string_literal: true

module Shopify
    module Address
      class CreateAddress
        def initialize(address_params)
          @customer_id = address_params[:customer_id]
          @address1 = address_params[:address1]
          @city = address_params[:city]
          @country_code = address_params[:country_code]
          @first_name = address_params[:first_name]
          @last_name = address_params[:last_name]
          @phone = address_params[:phone]
          @province = address_params[:province]
          @zip = address_params[:zip]
        end
  
        def self.call(*args)
          new(*args).create_address
        end
  
        def create_address
            url = URI("https://api.rechargeapps.com/addresses")
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true
            request = Net::HTTP::Post.new(url)
            request["x-recharge-version"] = '2021-11'
            request["Content-Type"] = 'application/json'
            request["x-recharge-access-token"] = ENV['RECHARGE_ACCESS_TOKEN']
            request.body = {
              "customer_id": @customer_id,
              "address1": @address1,
              "city": @city,
              "country_code": @country_code,
              "first_name": @first_name,
              "last_name": @last_name,
              "phone": @phone,
              "province": @province,
              "zip": @zip
            }.to_json
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
  