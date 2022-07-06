class AddInitialTypes < ActiveRecord::Migration[7.0]
  def up
      Type.create(name: "Bebidas Frías")
      Type.create(name: "Bebidas Calientes")
      Type.create(name: "Entrada")
      Type.create(name: "Plato Fuerte")
      Type.create(name: "Postre")
      Type.create(name: "Panadería")
  end

  def down
    Type.delete_all
  end
end
