class SharesController < ApplicationController

  def index
        @shares = Share.order(id: :desc).page(params[:page]).per(25)
  end
  
    def new
    @share = Share.new
  end


  def show
        @share = Share.find(params[:id])
        @myshare= @share.links.find_by(params[:id])
    if logged_in?
      @comment = current_user.comments.build  # form_with 用
      @comments = @share.comments.order(id: :desc).page(params[:page])
  end
  end

  def create
    @share = current_user.shares.build(share_params)
    if @share.save
      flash[:success] = 'シェアリング内容を投稿しました。'
      redirect_to shares_url(@share.id)
    else
      @shares = current_user.shares.order(id: :desc).page(params[:page])
      flash.now[:danger] = '作品の投稿に失敗しました。'
      render:new
    end
  end

  def destroy
    @share = Share.find(params[:id])
    @share.destroy
    flash[:success] = 'シェアリング内容を削除しました。'
      redirect_to shares_url(@share.id)
  end

  def discussion
        @share = Share.find(params[:id])

    if logged_in?
      @comment = current_user.comments.build  # form_with 用
      @comments = @share.comments.order(id: :desc).page(params[:page])
  end
  end

  private

  def share_params
    params.require(:share).permit(:title, :image, :content, :avatar)
  end
end