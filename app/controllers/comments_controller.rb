class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_model
  before_action :set_comment, only: %i[update destroy]

  api :GET, '/api/v1/comments'
  description 'Index all tasks for task'
  param :task_id, [Integer, String], desc: 'Task id', required: true

  def index
    comments = set_model.where(task_id: params[:task_id])
    pagy, records = pagy(comments, page: @page, items: @items, outset: @outset)
    render json: CommentSerializer.new(records, pagination_options(pagy)).serialized_json
  end

  api :POST, '/api/v1/comments'
  description 'Create a comment for task'
  param :comment, Hash, required: true do
    param :description, String, desc: 'Comment text', required: true
    param :attachment, File, desc: 'Task status'
  end

  def create
    comment = set_model.new(comment_params)
    if comment.save
      render json: CommentSerializer.new(comment)
    else
      render json: ErrorSerializer.new(comment).serialized_json,
             status: :unprocessable_entity
    end
  end

  api :PATCH, '/api/v1/comments'
  param :id, [Integer, String], desc: 'Comment id', required: true
  description 'Update a comment for task'
  param :comment, Hash, required: true do
    param :description, String, desc: 'Comment text', required: true
    param :attachment, File, desc: 'Task status'
  end

  def update
    if @comment.update(comment_params)
      render json: CommentSerializer.new(@comment)
    else
      render json: ErrorSerializer.new(@comment).serialized_json,
             status: :unprocessable_entity
    end
  end

  api :DELETE, '/api/v1/comments'
  description 'Delete a comment'
  param :id, [Integer, String], desc: 'Comment id', required: true

  def destroy
    @comment.destroy
  end

  private

  def set_model
    Comment.accessible_by(current_ability)
  end

  def set_comment
    @comment = set_model.find(params[:id])
  end

  def comment_params
    params.fetch(:comment, {}).permit(:description, :attachment, :task_id)
  end
end
