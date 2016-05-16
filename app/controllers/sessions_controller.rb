class SessionsController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.find(params[:user][:id])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "Welcome back to the theme park!"
      redirect_to user_path(@user)
    else
      flash[:notice] = "User does not exist."
      redirect_to signin_path
    end
  end

  def destroy
    if session[:user_id]
      reset_session
    end
    redirect_to '/'
  end
  
end