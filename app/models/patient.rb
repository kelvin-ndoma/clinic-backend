class Patient < ApplicationRecord
    has_secure_password
  
    # Associations
    has_many :appointments
  
    # Validations
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
  end
  
