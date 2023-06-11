class ServiciosAutoController < ApplicationController
  include Authentication

  def new
    @servicio = Servicio.new
    @vehiculos = Current.user.vehiculos if Current.user
  end

  def create
    @servicio = Servicio.new(servicio_params)
    if @servicio.save
      redirect_to root_path, notice: 'El servicio ha sido agendado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def obtener_patente
    modelo = params[:modelo]
    # Lógica para obtener la patente según el modelo de vehículo (puedes adaptarla a tus necesidades)
    patente = Vehiculo.find_by(modelo_vehiculo: modelo)&.patente_vehiculo
  
    render json: { patente: patente }
  end
  

  private

  def servicio_params
    params.require(:servicio).permit(:tipo_servicio, :modelo_vehiculo, :patente_vehiculo, :fecha, :hora, :comentario)
  end
end
