class TasksController < ApplicationController
  load_and_authorize_resource
  before_action :set_model
  before_action :set_task, only: %i[update destroy]

  api :GET, '/api/v1/tasks'
  description 'Index all tasks for project'
  param :project_id, [Integer, String], desc: 'Project id', required: true

  def index
    tasks = set_model.where(project_id: params[:project_id])
    pagy, records = pagy(tasks, page: @page, items: @items, outset: @outset)
    render json: TaskSerializer.new(records, pagination_options(pagy)).serialized_json
  end

  api :POST, '/api/v1/tasks'
  description 'Create a task for project'
  param :task, Hash, required: true do
    param :title, String, desc: 'Task title', required: true
    param :status, String, desc: 'Task status'
    param :deadline, DateTime, desc: 'Task deadline'
    param :position, Integer, desc: 'Task position'
    param :project_id, Integer, desc: 'Project id'
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

  api :PATCH, '/api/v1/tasks'
  description 'Update a task for project'
  param :id, [Integer, String], desc: 'Task id', required: true
  param :task, Hash, required: true do
    param :title, String, desc: 'Task title'
    param :status, String, desc: 'Task status'
    param :deadline, DateTime, desc: 'Task deadline'
    param :position, Integer, desc: 'Task position'
    param :project_id, Integer, desc: 'Project id'
  end

  def update
    if @task.update(task_params)
      render json: TaskSerializer.new(@task)
    else
      render json: ErrorSerializer.new(@task).serialized_json,
             status: :unprocessable_entity
    end
  end

  api :DELETE, '/api/v1/tasks'
  description 'Delete a task with comments'
  param :id, [Integer, String], desc: 'Task id', required: true

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
