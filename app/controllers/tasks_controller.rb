class TasksController < ApplicationController
  before_action :set_user
  before_action :set_task
  before_action :logged_in_user
  before_action :correct_user
  
  
  def index
    @tasks = @user.tasks
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = @user.tasks.new(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to user_task_path @user
    else
      render :edit
    end
  end
  
  def show
  end
  
  def destroy
    @task.destroy
    flash[:success] = "タスクを削除しました。"
    redirect_to user_tasks_url @user
  end
  
  private
  
  def task_params
    params.require(:task).permit(:name, :details)
  end
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
  def set_task
    @task = @user.tasks.find_by(id: params[:id])
  end
  
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
  
  def correct_user
    unless current_user == @user
      flash[:danger] = "権限がありません。"
      redirect_to root_url
    end
  end
  
end
