class Customer < ApplicationRecord
    has_many :orders

    def to_s
        self.name + " - " + self.identification
    end
end
