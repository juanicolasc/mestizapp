class AddStatusToTables < ActiveRecord::Migration[7.0]
  def change
    add_column :tables, :status, :string, default: 'Disponible'
  end
end
