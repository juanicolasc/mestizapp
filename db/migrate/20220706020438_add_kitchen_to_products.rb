class AddKitchenToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :kitchen, :string
  end
end
