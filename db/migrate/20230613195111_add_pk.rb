class AddPk < ActiveRecord::Migration[7.0]
  def change
    change_column :vehiculos, :patente_vehiculo, :string, null: false
    add_index :vehiculos, :patente_vehiculo, unique: true
  end
end