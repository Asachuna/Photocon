class UsersController < ApplicationController
  layout 'no_sidebar', :only => [:new]
  
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:main] = 'ユーザー登録が完了しました。'
      redirect_to @user
    else
      flash.now[:accent] = 'ユーザーの登録に失敗しました。'
      render :new, layout: "no_sidebar"
    end
  end

  def new
    @user = User.new
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
