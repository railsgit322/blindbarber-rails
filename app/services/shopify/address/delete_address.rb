# frozen_string_literal: true

module Shopify
    module Address
      class DeleteAddress
        def initialize(id)
          @id = id
        end
  
        def self.call(*args)
          new(*args).delete_address
        end
  
        def delete_address
            url = URI("https://api.rechargeapps.com/addresses/#{@id}")
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true
            request = Net::HTTP::Delete.new(url)
            request["x-recharge-version"] = '2021-11'
            request["x-recharge-access-token"] = ENV['RECHARGE_ACCESS_TOKEN']
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
  