class UsersController < ApplicationController
  before_action :authenticate_user!
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  respond_to? :js, :html

  def index
    @users = User.search_by(params[:search])
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
    @user = User.create(user_params)
  end

  def update
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
      params.require(:user).permit(:name, :email)
    end
end