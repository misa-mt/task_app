class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update, :show, :destroy]
  before_action :admin_user, only: [:index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_or_correct_user, only: :show
  
  def index
    @users = User.all
    @users = User.paginate(page: params[:page], per_page: 20)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
    
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
  
  def admin_user
    unless current_user.admin?
      flash[:danger] = "権限がありません。"
      redirect_to root_url
    end
  end
  
  def correct_user
    unless current_user == @user
      flash[:danger] = "権限がありません。"
      redirect_to root_url
    end
  end
  
  def admin_or_correct_user
    unless current_user == @user || current_user.admin?
      flash[:danger] = "権限がありません。"
      redirect_to root_url
    end
  end
end
