class InfosController < ApplicationController
      before_action :require_user_logged_in

  def index
        @infos = Info.order(id: :desc).page(params[:page]).per(25)
  end
  
    def new
    @info = Info.new
  end


  def show
      @info = Info.find(params[:id])
    if logged_in?
      @answer = current_user.answers.build  # form_with 用
      @answers = current_user.answers.order(id: :desc).page(params[:page])
      
  end
  end

  def create
    @info = current_user.infos.build(info_params)
    if @info.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @infos = current_user.infos.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @info=Info.find(params[:id])
    @info.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def counts(user)
    @info = Info.find(params[:id])
    @count_answers = @info.answers.count
  end

  private

  def info_params
    params.require(:info).permit(:title, :content)
  end
end