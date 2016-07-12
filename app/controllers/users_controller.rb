class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  respond_to? :js, :html

  def index
    @users = User.search_by(params[:search])
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
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    @user.update(user_params)
  end

  def destroy
    @user.destroy
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end