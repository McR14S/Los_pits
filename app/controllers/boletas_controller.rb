class BoletasController < ApplicationController
  # ...

  def generar
    @servicio = Servicio.find(params[:id])
    @servicio.update(boleta_generada: true)
  
    respond_to do |format|
      format.html do
        pdf = generate_pdf(@servicio)
  
        send_data pdf.render, filename: 'boleta.pdf', type: 'application/pdf', disposition: 'attachment'
      end
      format.pdf do
        pdf = generate_pdf(@servicio)
  
        send_data pdf.render, filename: 'boleta.pdf', type: 'application/pdf', disposition: 'attachment'
      end
      
    end
  end
  
  def mostrar_ultima_boleta
    @ultima_boleta = Servicio.order(created_at: :desc).first
    redirect_to generar_boleta_path(@ultima_boleta) if @ultima_boleta
  end
  

  private

  def generate_pdf(servicio)
    pdf = Prawn::Document.new(page_size: "A4", page_layout: :portrait)
  
    # Configuración de la página
    pdf.pad(20) do
      pdf.move_down 100
      pdf.text "--Comprobante de Servicio--", align: :center, size: 25, style: :bold
      pdf.move_down 20
  
      pdf.bounding_box([pdf.bounds.left + 40, pdf.bounds.top - 300], width: pdf.bounds.width - 80, height: pdf.bounds.height - 440) do
        pdf.indent(20) do
          pdf.text "Tipo de servicio:", style: :bold
          pdf.text servicio.tipo_servicio, indent_paragraphs: 20
          pdf.move_down 10
  
          pdf.text "Modelo de vehículo:", style: :bold
          pdf.text servicio.modelo_vehiculo, indent_paragraphs: 20
          pdf.move_down 10
  
          pdf.text "Patente:", style: :bold
          pdf.text servicio.patente_vehiculo, indent_paragraphs: 20
          pdf.move_down 10
  
          pdf.text "Fecha:", style: :bold
          pdf.text servicio.fecha.to_s, indent_paragraphs: 20 # Convertir a cadena de texto con to_s
          pdf.move_down 10
  
          pdf.text "Hora:", style: :bold
          pdf.text servicio.hora.strftime('%H:%M:%S'), indent_paragraphs: 20 # Formato de hora: 13:00:00
          pdf.move_down 10
  
          pdf.text "Comentario:", style: :bold
          pdf.text servicio.comentario, indent_paragraphs: 20
        end
      end
  
      pdf.move_down 40
      pdf.text "¡Gracias por elegir nuestro servicio!", align: :center, style: :bold
    end
  
    pdf
  end
  
    
end
