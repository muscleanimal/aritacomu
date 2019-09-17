class UsersController < ApplicationController

  before_action :require_user_logged_in, only: [:index, :show]
  
  
  def index
        @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
      @user = User.find(params[:id])
      @infos = current_user.infos.order(id: :desc).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

def myinfos
      @user = User.find(params[:id])
  @myinfos = current_user.infos.order(id: :desc).page(params[:page])
end

def myworks
      @user = User.find(params[:id])
  @myworks = current_user.works.order(id: :desc).page(params[:page])
end

def myfaves
      @user = User.find(params[:id])
  @myfaves = current_user.favorites.order(id: :desc).page(params[:page])
end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
