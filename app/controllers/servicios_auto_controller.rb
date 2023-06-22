class ServiciosAutoController < ApplicationController
  include Authentication
  protect_from_forgery with: :exception


  def new
    @servicio = Servicio.new
    @vehiculos = Current.user.vehiculos if Current.user
    get_first_patente
  end

  def index
    authorize_admin!
    @servicios = Servicio.all
  end
  

  def create
    @servicio = Servicio.new(servicio_params)
    if @servicio.save
      redirect_to root_path, notice: 'El servicio ha sido agendado exitosamente.'
    else
      @vehiculos = Current.user.vehiculos if Current.user
      render :new, status: :unprocessable_entity
    end
  end

  def obtener_patente
    modelo = params[:modelo]
    # Lógica para obtener la patente según el modelo de vehículo (puedes adaptarla a tus necesidades)
    patente = Vehiculo.find_by(modelo_vehiculo: modelo)&.patente_vehiculo
  
    render json: { patente: patente }
  end

  def get_first_patente
    @first_patente = Vehiculo.first&.patente_vehiculo
  end
  

  private

  def servicio_params
    params.require(:servicio).permit(:tipo_servicio, :modelo_vehiculo, :patente_vehiculo, :fecha, :hora, :comentario, :completed)
  end

  def authorize_admin!
    unless Current.user.admin? || Current.user.superadmin?
      redirect_to root_path, alert: 'No tienes permisos de administrador.'
    end
  end

  def generate_pdf(servicio)
    # Aquí debes utilizar una biblioteca de generación de PDF, como Prawn o Wicked PDF, para generar el PDF con los datos del servicio.
    # A continuación se muestra un ejemplo utilizando Prawn:
    
    Prawn::Document.new do
      # Genera el contenido del PDF utilizando los datos del servicio
      text "Tipo de servicio: #{servicio.tipo_servicio}"
      text "Modelo de vehículo: #{servicio.modelo_vehiculo}"
      text "Patente: #{servicio.patente_vehiculo}"
      text "Fecha: #{servicio.fecha}"
      text "Hora: #{servicio.hora}"
      text "Comentario: #{servicio.comentario}"
    end
  end
  
end
