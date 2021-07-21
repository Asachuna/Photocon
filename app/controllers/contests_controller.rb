class ContestsController < ApplicationController
  
  before_action :require_user_logged_in, only: [:new, :create, :destroy]

  
  def index
    
  end
  
  def new
    @contest = current_user.contests.build
  end

  def create
    @contest = current_user.contests.build(contest_params)

    if @contest.save
      flash[:main] = 'コンテストを作成しました。'
      redirect_to @contest
    else
      flash.now[:accent] = 'コンテストの作成に失敗しました。'
      render :new
    end
  end

  def show
     @contest = Contest.find((params[:id]))
  end

  def destroy
    @contest = current_user.contests.find_by(id: params[:id])
    if @contest
      @contest.destroy
      flash[:main] = "コンテストを削除しました。"
      redirect_to contests_url
    else
      redirect_to @contest
    end
  end
  
  private

  def contest_params
    params.require(:contest).permit(:name, :description, :closing_day)
  end
  
end
