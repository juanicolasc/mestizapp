class CreateKitchens < ActiveRecord::Migration[7.0]
  def change
    create_table :kitchens do |t|
      t.string :name

      t.timestamps
    end
  end
end
