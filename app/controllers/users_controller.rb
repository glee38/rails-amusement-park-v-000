class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    if !logged_in?
      flash[:alert] = "You must be signed in to view a user."
      redirect_to users_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the theme park!"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
    if !logged_in?
      flash[:alert] = "You must be signed in to edit your profile."
      redirect_to root_path
    elsif @user != current_user
      flash[:alert] = "You cannot update another user's profile."
      redirect_to user_path(current_user)
    end
  end

  def update
    @user.update(user_params)
    flash[:notice] = "User was successfully updated."
    redirect_to user_path(@user)
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :nausea, :happiness, :tickets, :height, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

end