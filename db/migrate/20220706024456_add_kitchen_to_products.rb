class AddKitchenToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :kitchen, null: false, foreign_key: true, default: 1
  end
end
