class AddDataToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :aditions, :integer
    add_column :orders, :final_value, :integer
  end
end
