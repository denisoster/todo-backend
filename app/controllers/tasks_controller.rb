class TasksController < ApplicationController
  load_and_authorize_resource
  before_action :set_model
  before_action :set_task, only: %i[update destroy]

  def index
    tasks = set_model.where(project_id: params[:project_id])
    pagy, records = pagy(tasks, page: @page, items: @items, outset: @outset)
    render json: TaskSerializer.new(records, pagination_options(pagy)).serialized_json
  end

  def create
    task = set_model.new(task_params)
    if task.save
      render json: TaskSerializer.new(task)
    else
      render json: ErrorSerializer.new(task).serialized_json,
             status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: TaskSerializer.new(@task)
    else
      render json: ErrorSerializer.new(@task).serialized_json,
             status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
  end

  private

  def set_model
    Task.accessible_by(current_ability)
  end

  def set_task
    @task = set_model.find(params[:id])
  end

  def task_params
    params.fetch(:task, {}).permit(:title, :status, :deadline, :position, :project_id)
  end
end
