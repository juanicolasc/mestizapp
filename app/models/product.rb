class Product < ApplicationRecord
  has_many :items


  validates :name, uniqueness: { scope: :active, if: :active?, message: "Ya hay otro producto activo con este nombre" }, presence: true
  validates_presence_of :description
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0  }

  def decrement_stock(quantity)
     self.stock -= quantity
     self.save
  end

  def increment_stock(quantity)
     self.stock += quantity
     self.save
  end
end
