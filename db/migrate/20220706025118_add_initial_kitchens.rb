class AddInitialKitchens < ActiveRecord::Migration[7.0]
  def up
    2.times do |i|
      Kitchen.create(name: "Cocina #{i}")
    end
  end

  def down
    Kitchen.delete_all
  end
end
