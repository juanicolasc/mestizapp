class Customer < ApplicationRecord
    validates_presence_of :name
    validates :identification, uniqueness: true, allow_blank: true
    validates :email, uniqueness: true, allow_blank: true
    has_many :orders

    def to_s
        self.name + " - " + self.identification
    end
end
