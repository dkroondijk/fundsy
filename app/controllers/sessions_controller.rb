class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email params[:email]
    # authenticate comes from has_secure_password user.rb
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Logged in Succesfully"
    else
      render :new
      flash[:alert] = "Wrong Credentials"
    end
    
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged Out Succesfully"
    redirect_to root_path
  end
end
