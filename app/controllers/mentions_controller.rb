class MentionsController < ApplicationController
  before_action :require_user_logged_in


  def create
  @mention = current_user.mentions.build(work_params)
    if @mention.save
      work = Work.find(params[:id])
  @mention.work_id = work.id
  @mention.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_to work
    else
      @mentions = current_user.mentions.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'コメントの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @work.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def work_params
    params.require(:mention).permit(:comment, :work_id)
  end

  def correct_user
    @mention = current_user.mentions.find_by(id: params[:id])
    unless @mention
      redirect_to root_url
    end
  end



end