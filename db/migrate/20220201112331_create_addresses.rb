class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :address1
      t.string :address2
      t.string :city
      t.string :province
      t.string :country
      t.string :zip
      t.string :company
      t.string :phone
      t.boolean :is_default, default: false

      t.timestamps
    end
  end
end
