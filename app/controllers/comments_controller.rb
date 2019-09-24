class CommentsController < ApplicationController
  before_action :require_user_logged_in

  def create
  @comment = current_user.comments.build(share_params)
    if @comment.save
      share = Share.find(params[:id])
  @comment.share_id = share.id
  @comment.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_to discussion_share_url(@comment.share_id)
    else
      @comments = current_user.comments.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'コメントの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def share_params
    params.require(:comment).permit(:comment, :share_id)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end



end