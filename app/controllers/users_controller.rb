class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  respond_to? :js, :html

  def index
    @users = User.all
    @user = User.new
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
      flash.now.notice = 'Se ha creado el nuevo usuario.'
    end
  end

  def update
    if @user.update(user_params)
      flash.now.notice = 'El usuario ha sido modificado.'
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