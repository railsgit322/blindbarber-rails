class CreateShopifyStoreAccess < ActiveRecord::Migration[7.0]
  def change
    create_table :shopify_store_accesses do |t|
      t.string :store_name
      t.string :code
      t.string :admin_access_token
      t.string :storefront_access_token

      t.timestamps
    end
  end
end
