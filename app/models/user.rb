class User < ApplicationRecord
  ADMIN = 1
  WAITER = 2
  CHEF = 3
  CASHIER = 4

  has_many :orders
  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :profile

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.pasword_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.pasword_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def admin?
     self.profile == (User::ADMIN)
  end

  def to_s
      self.email
  end
end
