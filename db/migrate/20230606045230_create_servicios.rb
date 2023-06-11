class CreateServicios < ActiveRecord::Migration[7.0]
  def change
    create_table :servicios do |t|
      t.string :tipo_servicio, null: false
      t.string :modelo_vehiculo, null: false
      t.string :patente_vehiculo, null: false
      t.date :fecha, null: false
      t.time :hora, null: false
      t.text :comentario

      t.timestamps
    end
  end
end