class SessionsController < ApplicationController



  def new
    @user = User.new
    render :new
  end
  def create
    @user = User.find_by_credentials(params[:user][:email],
    params[:user][:password])
    if @user.nil?
      @user = User.new
      render :new
    else
      login_user(@user)
    end

  end

  def destroy
    if current_user
      logout
    end
  end

end
