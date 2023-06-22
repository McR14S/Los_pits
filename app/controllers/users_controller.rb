class UsersController < ApplicationController
  before_action :authorize_superadmin!
  skip_before_action :protect_pages, only: [:show]

  def show
    @user = User.find_by!(username: params[:username])
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = usuario
  end

  def update
    @user = usuario
    if @user.update(user_params)
      # La actualización fue exitosa
      redirect_to user_path(@user), notice: "El perfil se ha actualizado correctamente."
    else
      # Hubo un error en la actualización, muestra el formulario nuevamente
      render :edit, status: :unprocessable_entity
    end
  end

  #Eliminacion  con el ID
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      head :no_content
    else
      render json: { error: 'No se pudo eliminar el usuario' }, status: :unprocessable_entity
    end
  end
  
  
  private

  def usuario
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :admin, :superadmin)
  end

  def authorize_superadmin!
    unless Current.user&.superadmin?
      redirect_to root_path, alert: 'No tienes permisos de superadmin.'
    end
  end
end
