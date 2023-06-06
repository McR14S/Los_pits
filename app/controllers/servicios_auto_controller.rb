class ServiciosAutoController < ApplicationController

    def new
        @servicio = Servicio.new
    end

    def create
        @servicio = Servicio.new(servicio_params)
        if @servicio.save
            # Lógica adicional, como enviar un correo, redireccionar, etc.
            redirect_to root_path, notice: 'El servicio ha sido agendado exitosamente.'
        else
            render :new
        end
    end

    private

    def servicio_params
        params.require(:servicio).permit(:tipo_servicio, :modelo_vehiculo, :patente_vehiculo, :fecha, :hora, :comentario)
    end
end
