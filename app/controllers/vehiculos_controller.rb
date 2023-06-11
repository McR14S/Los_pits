class VehiculosController < ApplicationController
    def new
      @vehiculo = Vehiculo.new
    end
  
    def create
      @vehiculo = Vehiculo.new(vehiculo_params)
      if @vehiculo.save
        # Redirige a la página deseada después de guardar el vehículo exitosamente
        redirect_to perfil_path, notice: "Vehículo agregado correctamente"
      else
        render :new,  status: :unprocessable_entity
      end
    end
  
    private
  
    def vehiculo_params
      params.require(:vehiculo).permit(:modelo_vehiculo, :patente_vehiculo, :marca_vehiculo, :color_vehiculo)
    end
end
  