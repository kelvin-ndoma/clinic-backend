class Appointment < ApplicationRecord
  belongs_to :patient
  has_one :doctor, through: :patient
end

