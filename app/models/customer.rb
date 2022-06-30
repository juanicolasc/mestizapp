class Customer < ApplicationRecord
    validates_presence_of :name
    has_many :orders

    def to_s
        self.name + " - " + self.identification
    end
end
