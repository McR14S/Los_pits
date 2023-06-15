class Vehiculo < ApplicationRecord

    validates :modelo_vehiculo, presence: true

    validates :patente_vehiculo, presence: true, uniqueness: true, 
    length: { in: 4..7 },
    format: { with: /\A[A-Z]{2}\d{4}\z/, 
            message: "debe tener el formato de una patente chilena válida" }  
    
    validates :marca_vehiculo, presence: true
    validates :color_vehiculo, presence: true

    #le asigna el ID del usuario logeado
    belongs_to :user, default: -> { Current.user }
end
