class WorksController < ApplicationController
      before_action :require_user_logged_in

  def index
        @works = Work.order(id: :desc).page(params[:page]).per(25)
  end
  
    def new
    @work = Work.new
  end


  def show
        @work = Work.find(params[:id])
        @user = User.find(params[:id])
    if logged_in?
      @mention = current_user.mentions.build  # form_with 用
      @mentions = current_user.mentions.order(id: :desc).page(params[:page])
      
  end
  end

  def create
    @work = current_user.works.build(work_params)
    if @work.save
      flash[:success] = '作品を投稿しました。'
    redirect_to :user
    
    else
      @works = current_user.works.order(id: :desc).page(params[:page])
      flash.now[:danger] = '作品の投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @work.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def likes
    @user =User.find(params[:id])
    @likes=@user.likes.page(params[:page]).per(25)
end 


  private

  def work_params
    params.require(:work).permit(:title, :image, :content)
  end
end