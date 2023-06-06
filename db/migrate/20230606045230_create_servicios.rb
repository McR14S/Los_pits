class CreateServicios < ActiveRecord::Migration[7.0]
  def change
    create_table :servicios do |t|
      t.string :tipo_servicio
      t.string :modelo_vehiculo
      t.string :patente_vehiculo
      t.date :fecha
      t.time :hora
      t.text :comentario

      t.timestamps
    end
  end
end
