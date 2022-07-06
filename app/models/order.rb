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


  #metodo auxiliar para evaluar si la orden se está atendiendo o no
  def alive?
      ((self.status == 'Iniciada' or self.status == 'Sirviendo') and  self.active == true)
  end

  #metodo para saber si la orden finalizó
  def closed?
      (self.status == 'Pagada')
  end

  #metodo para actualizar el total de la orden, siempre devuelve al estado inicial con el objeto de que el mesero confirme
  def update_total
      self.update({:total_value => (self.items.map(&:total).inject(0, &:+)), :status => 'Iniciada'})
  end

  #cuando inicializa debe arrancar con los valores en 0 y en el estado inicial
  after_initialize do
      self.status ||= 'Iniciada'
      self.total_value ||= 0
      self.aditions ||= 0
      self.final_value ||= 0
      self.tax ||= 0
      self.tip ||= 0
  end

  #cada vez que se actualice cualquier dato se debe confirmar que el valor final es correcto.
  before_save do
      self.final_value = (self.total_value + self.aditions + self.tax + self.tip)
  end

  #cada vez que se guarda se debe verificar el estado para liberar o ocupar la mesa, además debe alistar los items para que se tengan en cuenta en la cocina, si y sólo si quedó confirmada.
  after_save do
    if self.alive?
      self.table.occupy
    else
      self.table.liberate
    end
    if self.status == 'Sirviendo'
      self.items.each do |item|
          item.confirm
      end
    end
  end

  #cuando se anula una orden no se debe eliminar del sistema, solo bajar la bandera activa, se debe liberar la mesa y si hasta ahora se estaba sirviendo o hasta ahora se estaba tomando el pedido se debe retornar el stock de cada producto
  #TODO: se debe agregar un motivo de anulación.
  def destroy
    update_attribute(:active, false)
    self.table.liberate
    if (self.status == 'Iniciada' or self.status == 'Sirviendo')
        self.items.each do |item|
          item.destroy
        end
    end
  end
end
