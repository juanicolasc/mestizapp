class Order < ApplicationRecord
  belongs_to :user
  belongs_to :customer, optional: true
  belongs_to :table
  has_many :items

  validates_presence_of :table
  validates_presence_of :date
  validates :guests, numericality: { only_integer: true, greater_than_or_equal_to: 1  }

  VALID_STATUSES = ['Iniciada', 'Sirviendo', 'Cuenta', 'Pagada']
  #TODO: se pueden agregar más métodos de pago no quiero hacer un modelo con esto aún
  PAYMENT_METHODS = ['Efectivo', 'Nequi']

  validates :status, inclusion: { in: VALID_STATUSES }


  def update_total
      self.update(:total_value => (self.items.map(&:total).inject(0, &:+)))
  end

  def alive?
      (self.status == 'Iniciada' or self.status == 'Sirviendo')
  end

  def closed?
      (self.status == 'Pagada')
  end

  after_initialize do
      self.status ||= 'Iniciada'
      self.total_value ||= 0
      self.aditions ||= 0
      self.final_value ||= 0
      self.tax ||= 0
      self.tip ||= 0
  end

  before_save do
      self.final_value = (self.total_value + self.aditions + self.tax + self.tip)
  end
end
