class Item < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1  }
  validates_presence_of :product
  validates_presence_of :order

  #debería agregar quien fue el mesero que agrgó el item
  before_create do
      self.price_unit = self.product.price
      self.total = self.price_unit * self.quantity
  end
end
