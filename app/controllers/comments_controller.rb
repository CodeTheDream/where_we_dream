class CommentsController < ApplicationController
  before_filter :load_commentable

  def index
    @school = School.find(params[:school_id])
    @comments = @commentable.comments.order(created_at: :desc)
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.save
    @blank_comment = @commentable.comments.new
    render :reply if @comment.original_comment_id
  end

  def destroy
    # write some code here nah mean
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :content, :original_comment_id)
  end

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end
