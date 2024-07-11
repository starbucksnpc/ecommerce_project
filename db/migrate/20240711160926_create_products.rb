class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.decimal :sale_price
      t.decimal :new_arrival
      t.string :image_url
      t.integer :stock_quantity

      t.timestamps
    end
  end
end
