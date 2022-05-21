class Order < ApplicationRecord
  belongs_to :user
  belongs_to :customer, optional: true
  belongs_to :table


  validates_presence_of :table
  validates_presence_of :date
end
