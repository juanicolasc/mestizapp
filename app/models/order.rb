class Order < ApplicationRecord
  belongs_to :user
  belongs_to :customer, optional: true
  belongs_to :table
  has_many :items


  validates_presence_of :table
  validates_presence_of :date
  validates :guests, numericality: { only_integer: true, greater_than_or_equal_to: 1  }


  def update_total
      tips = self.tip || 0
      self.update(:total_value => (self.items.map(&:total).inject(0, &:+))+tips )
  end

end
