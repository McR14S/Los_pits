class UsersController < ApplicationController
  before_action :authorize_superadmin!
  skip_before_action :protect_pages, only: :show

  def show
    @user = User.find_by!(username: params[:username])
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'Usuario creado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'Usuario eliminado exitosamente.'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :admin, :superadmin)
  end

  def authorize_superadmin!
    unless Current.user&.superadmin?
      redirect_to root_path, alert: 'No tienes permisos de superadmin.'
    end
  end
end
