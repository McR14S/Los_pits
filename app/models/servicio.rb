class Servicio < ApplicationRecord
    attribute :boleta_generada, :boolean, default: false
    validates :tipo_servicio, :modelo_vehiculo, :patente_vehiculo, :fecha, :hora, presence: true
end
  