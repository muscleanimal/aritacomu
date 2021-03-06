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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user =User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'プロフィール は正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] = 'プロフィール は更新されませんでした'
      render :edit
    end
  end

    def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = '退会しました。'
    redirect_back(fallback_location: root_path)
  end

def myinfos
      @user = User.find(params[:id])
  @myinfos = @user.infos.order(id: :desc).page(params[:page])

end

def myworks
      @user = User.find(params[:id])
  @myworks = @user.works.order(id: :desc).page(params[:page])
  
end

def myfaves
      @user = User.find(params[:id])
  @myfaves = @user.favorites.order(id: :desc).page(params[:page])
end

def myshares
      @user = User.find(params[:id])
  @myshares = @user.shares.order(id: :desc).page(params[:page])
end

  private

  def user_params
    params.require(:user).permit(:name, :email, :intro, :password, :password_confirmation, :avatar)
  end
end

  def counts(myinfo)
    @count_info=myinfo.answers.count
  end