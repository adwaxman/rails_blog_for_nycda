class SessionsController < ApplicationController
  def new
  end

  def create
    puts "************ PARAMS *****************"
    puts params
    @user = User.find_by(email: params[:email])
    if @user and @user[:password] == params[:password]
      session[:user_id] = @user[:id]
      flash[:notice] = "You have successfully logged in."
      redirect_to user_path(@user)
    else
      flash[:alert] = "There was a problem logging in."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to login_path
  end


end
