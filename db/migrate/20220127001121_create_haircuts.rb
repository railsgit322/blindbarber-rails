class CreateHaircuts < ActiveRecord::Migration[7.0]
  def change
    create_table :haircuts do |t|
      t.string :title
      t.text :body
      t.string :front_photo
      t.string :side_photo
      t.string :back_photo
      t.string :misc_photo
      t.integer :user_id
      t.index :user_id
      t.timestamps
    end
  end
end
