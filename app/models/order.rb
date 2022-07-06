class Order < ApplicationRecord
  belongs_to :user
  belongs_to :customer, optional: true
  belongs_to :table
  has_many :items

  validates :table, presence: true, if: :alive?
  validates_presence_of :date
  validates :guests, numericality: { only_integer: true, greater_than_or_equal_to: 1  }

  VALID_STATUSES = ['Iniciada', 'Sirviendo', 'Cuenta', 'Pagada']
  #TODO: se pueden agregar más métodos de pago no quiero hacer un modelo con esto aún
  PAYMENT_METHODS = ['Efectivo', 'Nequi']

  validates :status, inclusion: { in: VALID_STATUSES }


  def alive?
      ((self.status == 'Iniciada' or self.status == 'Sirviendo') and  self.active == true)
  end

  def closed?
      (self.status == 'Pagada')
  end

  #metodo para actualiza
  def update_total
      self.update({:total_value => (self.items.map(&:total).inject(0, &:+)), :status => 'Iniciada'})
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


  after_save do
    if self.alive?
      self.table.occupy
    else
      self.table.liberate
    end
  end

  def destroy
    update_attribute(:active, false)
    self.table.liberate
    if (self.status == 'Iniciada' or self.status == 'Sirviendo')
        self.items.each do |book|
          book.destroy
        end
    end
  end
end
