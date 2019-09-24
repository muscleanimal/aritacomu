class LinksController < ApplicationController
  before_action :require_user_logged_in

  def create
    share = Share.find(params[:share_id])
    current_user.share(share)
    flash[:success] = 'マッチング成立！シェアリング詳細ページからお相手とやり取りを始めましょう！'
    redirect_to  share_url(share)
  end

  def destroy
    share = Share.find(params[:share_id])
    current_user.unshare(share)
    flash[:success] = 'マッチングを解除しました。'
    redirect_to share_url(share)
  end
end