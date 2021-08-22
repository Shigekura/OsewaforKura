class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end
  def show
    @user = User.find(params[:id])
    @kurarecords = @user.kurarecords.order(clock: :desc).page(params[:page])
    counts(@user)
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'お世話係を登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'お世話係の登録に失敗しました。'
      render :new
    end
  end
    #ユーザー登録したら同時にログインすべきかもしれないが、やめておく
  def edit
    #@user = User.idはよくないと思う
    @user = User.find(params[:id])
    #既存データがプリセットされているはず
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success]='お世話係登録を修正しました。'
      redirect_to @user
    else
      flash[:success]='お世話係登録を修正できませんでした。'
      render :new
    end
  end
  def destroy
    @user.destroy
    #ログイン状態も解除する必要あり
    #投稿も削除するか？ユーザが削除されてしまっているお世話記録は情報的には表示した方がいいが、その管理はどうするか？
    flash[:success] = 'お世話係登録を削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
