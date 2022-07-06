class Item < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1  }
  validates_presence_of :product
  validates_presence_of :order
  validate :enough_stock, on: :create
  validate :enough_new_stock, on: :update


  VALID_STATUSES = ['Solicitado', 'Confirmado', 'Cocinando', 'Listo']
  validates :status, inclusion: { in: VALID_STATUSES }

  #pasa el item  al estado confirmado para que pueda ser tomado por la cocina correspondiente, no debe hacer cambios sobre items que ya han sido previamente confirmados
  def confirm
      if self.status == 'Solicitado'
          self.update(:status => 'Confirmado')
      end
  end

  #actualizar siempre el precio total
  before_save do
      self.price_unit = self.product.price
      self.total = self.price_unit * self.quantity
  end

  #cada item siempre arranca con el status incial
  after_initialize do
      self.status ||= 'Solicitado'
  end

  #cuando se elimine un item debe decrementar el precio de la orden y devolver el stock, en una orden en estado de cuenta o pagado no se debería poder eliminar un item
  after_destroy do
      self.order.total_value -= self.total
      self.order.save
      self.product.increment_stock(self.quantity.to_i)
  end

  #siempre se debe actualizar el total de la orden cuando se guarda o se actualiza un item
  after_save do
      self.order.update_total
  end

  #una vez se ha creado el item se debe decrementar el stock del producto capturado
  after_create do
      self.product.decrement_stock(self.quantity)
  end

  #cuando se actualice se debe decrementar o incrementar el stock del producto, según corresponda
  before_update do
    if self.product and (self.quantity_changed?)
        era = self.quantity_was.to_i
        es = self.quantity.to_i
        if es > era
            self.product.decrement_stock(es - era)
        else
            self.product.increment_stock(era - es)
        end
    end
  end

  private

  def enough_stock
     if self.product and (self.quantity > self.product.stock)
      errors.add(:quantity, "No hay cantidad suficiente, sólo hay #{self.product.stock}")
     end
  end

  def enough_new_stock
     if self.product and (self.quantity_changed?)
      era = self.quantity_was.to_i
      es = self.quantity.to_i
      if (es > era) and ((es - era) > self.product.stock.to_i)
        errors.add(:quantity, "No puedes agregar #{es - era} adicionales. No hay cantidad suficiente, sólo hay #{self.product.stock}")
      end
     end
  end
end
