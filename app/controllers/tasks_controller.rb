class TasksController < ApplicationController
  before_action :set_user
  before_action :set_task
  
  def index
    @tasks = Task.all
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
    if @task.save
      flash[:success] = "タスクを更新しました。"
      redirect_to user_task_path @user
    else
      render :edit
    end
  end
  
  def show
    @task = @user.tasks.find(params[:id])
  end
  
  private
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
  def set_task
    @task = Task.find(params[:user_id])
  end
  
  def task_params
    params.require(:task).permit(:name, :details)
  end
end
