class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'Se ha creado el nuevo usuario.'
    else
      flash.now.alert = "Hubo un error creando el nuevo usuario. Revise el formulario."
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'El usuario ha sido modificado.'
    else
      flash.now.alert = "Hubo un error modificando el nuevo usuario. Revise el formulario."
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'Se ha eliminado el usuario.'
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email)
    end
end