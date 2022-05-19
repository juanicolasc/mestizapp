class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :stock
      t.boolean :active
      t.integer :price

      t.timestamps
    end
  end
end
