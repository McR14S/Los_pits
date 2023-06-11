class CreateVehiculos < ActiveRecord::Migration[7.0]
  def change
    create_table :vehiculos do |t|
      t.string :modelo_vehiculo, null: false
      t.string :patente_vehiculo, null: false
      t.string :marca_vehiculo, null: false
      t.string :color_vehiculo, null: false

      t.timestamps
    end
  end
end
