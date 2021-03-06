class SessionsController < ApplicationController
  
  layout "no_sidebar"
  
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:main] = 'ログインに成功しました。'
      redirect_to @user
    else
      flash.now[:accent] = 'ログインに失敗しました。'
      render :new, layout: "no_sidebar"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:main] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
