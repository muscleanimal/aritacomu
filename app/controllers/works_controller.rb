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
    if logged_in?
      @mention = current_user.mentions.build  # form_with 用
      @mentions = @work.mentions.order(id: :desc).page(params[:page])
      
  end
  end

  def create
    @work = current_user.works.build(work_params)
    if @work.save
      flash[:success] = '作品を投稿しました。'
    redirect_to works_url(@work.id)
    
    else
      flash.now[:danger] = '作品の投稿に失敗しました。'
      render :new
    end
  end

  def destroy
    @work=Work.find(params[:id])
    @work.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_to works_url(@work.id)
  end

  def likes
    @user =User.find(params[:id])
    @likes=@user.likes.page(params[:page]).per(25)
end 


  private

  def work_params
    params.require(:work).permit(:title, :image, :content, :avatar)
  end
end