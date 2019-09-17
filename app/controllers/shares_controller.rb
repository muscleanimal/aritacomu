class SharesController < ApplicationController

  def index
        @shares = Share.order(id: :desc).page(params[:page]).per(25)
  end
  
    def new
    @share = Share.new
  end


  def show
        @share = Share.find(params[:id])
        @user = User.find(params[:id])
  end

  def create
    @share = current_user.shares.build(share_params)
    if @share.save
      flash[:success] = 'シェアリング内容を投稿しました。'
      redirect_to root_url
    else
      @shares = current_user.shares.order(id: :desc).page(params[:page])
      flash.now[:danger] = '作品の投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @share.destroy
    flash[:success] = 'シェアリング内容を削除しました。'
    redirect_back(fallback_location: root_path)
  end



  private

  def share_params
    params.require(:work).permit(:title, :image, :content)
  end
end