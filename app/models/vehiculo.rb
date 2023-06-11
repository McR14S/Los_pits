class Vehiculo < ApplicationRecord

    validates :modelo_vehiculo, presence: true
    validates :patente_vehiculo, presence: true
    validates :marca_vehiculo, presence: true
    validates :color_vehiculo, presence: true

    #le asigna el ID del usuario logeado
    belongs_to :user, default: -> { Current.user }
end
