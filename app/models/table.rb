class Table < ApplicationRecord
    has_many :orders


    VALID_STATUSES = ['Ocupada', 'Disponible']
    validates :status, inclusion: { in: VALID_STATUSES }

    after_initialize do
      self.status ||= 'Disponible'
    end

    def liberate
        self.update_column(:status, 'Disponible')
    end

    def occupy
        self.update_column(:status, 'Ocupada')
    end
end
