class ProjectsController < ApplicationController
  load_and_authorize_resource
  before_action :set_model
  before_action :set_project, only: %i[update destroy]

  def index
    projects = set_model
    pagy, records = pagy(projects, page: @page, items: @items, outset: @outset)
    render json: ProjectSerializer.new(records, pagination_options(pagy)).serialized_json
  end

  def create
    project = set_model.new(project_params)
    if project.save
      render json: ProjectSerializer.new(project)
    else
      render json: ErrorSerializer.new(project).serialized_json,
             status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: ProjectSerializer.new(@project)
    else
      render json: ErrorSerializer.new(@project).serialized_json,
             status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
  end

  private

  def set_model
    Project.accessible_by(current_ability)
  end

  def set_project
    @project = set_model.find(params[:id])
  end

  def project_params
    params.fetch(:project, {}).permit(:title)
  end
end
