class AddHaircutCountToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :haircuts_count, :integer
  end
end
