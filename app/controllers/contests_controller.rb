class ContestsController < ApplicationController
  
  include ContestsHelper
  before_action :require_user_logged_in, only: [:new, :create, :destroy]

  
  def index
    @pagy, @contests = pagy(Contest.all.order(id: :desc), items: 20)
  end
  
  def new
    @contest = current_user.contests.build
  end

  def create
    @contest = current_user.contests.build(contest_params)
    
    if correct_user?(@contest)

      if @contest.save
        flash[:main] = 'コンテストを作成しました。'
        redirect_to @contest
      else
        flash.now[:accent] = 'コンテストの作成に失敗しました。'
        render :new
      end
    else
      flash[:main] = 'コンテストの作成に失敗しました。'
      redirect_to contests_url
    end
  end

  def show
    @contest = Contest.find((params[:id]))
    if contest_in_progress?(@contest)
      @pagy, @photos = pagy(@contest.photos.order(id: :desc), items: 20)
    else
      #写真のランクを取得したい際はこれと同様の計算を毎回行っているが、非効率なので余裕があればphotosにrankカラムを追加するなどして対応
      photos =  @contest.photos.sort { |a, b| b.count_likes <=> a.count_likes }
      @pagy, @photos = pagy_array(photos, items: 20)
    end
  end

  def destroy
    @contest = current_user.contests.find_by(id: params[:id])
    if @contest
      @contest.destroy
      flash[:main] = "コンテストを削除しました。"
      redirect_to contests_url
    else
      redirect_to contest_path(params[:id])
    end
  end
  
  private

  def contest_params
    params.require(:contest).permit(:name, :description, :closing_day)
  end
  
end
