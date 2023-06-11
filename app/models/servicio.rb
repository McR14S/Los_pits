class Servicio < ApplicationRecord
    validates :tipo_servicio, :modelo_vehiculo, :patente_vehiculo, :fecha, :hora, presence: true
end
  