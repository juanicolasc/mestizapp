class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.date :date
      t.text :observations
      t.integer :total_value
      t.integer :tax
      t.integer :tip
      t.integer :guests
      t.boolean :active
      t.references :user, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :table, null: false, foreign_key: true

      t.timestamps
    end
  end
end
