class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.references :patient, null: false, foreign_key: true
      t.string :service
      t.datetime :datetime

      t.timestamps
    end
  end
end
