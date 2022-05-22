class Order < ApplicationRecord
  belongs_to :user
  belongs_to :customer, optional: true
  belongs_to :table
  has_many :items


  validates_presence_of :table
  validates_presence_of :date
  validates :guests, numericality: { only_integer: true, greater_than_or_equal_to: 1  }
end
