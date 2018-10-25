class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_model
  before_action :set_comment, only: %i[update destroy]


  def index
    comments = set_model.where(task_id: params[:task_id])
    pagy, records = pagy(comments, page: @page, items: @items, outset: @outset)
    render json: CommentSerializer.new(records, pagination_options(pagy)).serialized_json
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

  def update
    if @comment.update(comment_params)
      render json: CommentSerializer.new(@comment)
    else
      render json: ErrorSerializer.new(@comment).serialized_json,
             status: :unprocessable_entity
    end
  end

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
