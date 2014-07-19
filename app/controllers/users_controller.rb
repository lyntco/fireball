class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
    unless @user.id == @current_user.id
      redirect_to root_path
    end
  end

  def show
    @user = @current_user
    if @user.nil?
      redirect_to root_path
    end
  end

  def update
    @user = User.find params[:id]
    @user.update user_params

    redirect_to users_path
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy

    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar, :native_language)
  end
end