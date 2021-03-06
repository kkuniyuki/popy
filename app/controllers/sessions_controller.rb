class SessionsController < ApplicationController
  def new
  end
  
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:alert] = "POPPY!! #{@user.name}さん"
      redirect_to "/welcomes/#{@user.id}"
      # redirect_to index_path(@user)
    else
      flash[:alert] = 'email/passwordどちらかに誤りがあります。'
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
