class AddTypeToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :type, null: false, foreign_key: true, default: 1
  end
end
