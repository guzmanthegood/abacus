class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :check_password, only: [:update]
  respond_to? :js, :html

  def index
    @users = User.search(params[:search])
    @user = User.new
  end

  # /profile
  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.create(user_params)
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to profile_path, notice: 'Datos de usuario modificados correctamente' }
        format.js   { }
      else
        format.html { render :show }
        format.js   { }
      end    
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to new_user_session_path, notice: 'Su usuario ha sido eliminado' }
      format.js { }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def check_password
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
    end
end