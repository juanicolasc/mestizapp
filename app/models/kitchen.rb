class Kitchen < ApplicationRecord
  has_many :products

  validates :name, uniqueness: {message: "Ya hay otro producto activo con este nombre" }, presence: true
end
