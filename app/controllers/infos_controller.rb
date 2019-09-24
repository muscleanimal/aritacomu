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
      @answers = @info.answers.order(id: :desc).page(params[:page])
      
  end
  end

  def create
    @info = current_user.infos.build(info_params)
    if @info.save
      flash[:success] = '質問を投稿しました。'
      redirect_to infos_url(@info.id)
    else
      @infos = current_user.infos.order(id: :desc).page(params[:page])
      flash.now[:danger] = '質問の投稿に失敗しました。'
           redirect_to infos_url(@info.id)
    end
  end

  def destroy
    @info=Info.find(params[:id])
    @info.destroy
    flash[:success] = '質問を削除しました。'
    redirect_back(fallback_location: root_path)
  end


  private

  def info_params
    params.require(:info).permit(:title, :content, :avatar)
  end
end

def count
  self.answers.count
end