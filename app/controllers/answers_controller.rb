class AnswersController < ApplicationController
  before_action :require_user_logged_in


  def create
  @answer = current_user.answers.build(answer_params)
    if @answer.save
      info = Info.find(params[:id])
  @answer.info_id = info.id
  @answer.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @answers = current_user.answers.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @info.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def answer_params
    params.require(:answer).permit(:comment, :info_id)
  end

  def correct_user
    @answer = current_user.answers.find_by(id: params[:id])
    unless @answer
      redirect_to root_url
    end
  end



end