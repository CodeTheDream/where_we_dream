class CommentsController < ApplicationController
  before_filter :load_commentable

  def index
    @comments = @commentable.comments.where(original_comment_id: nil).order(created_at: :desc)
    @blank_comment = Comment.new
  end

  # Does this controller action even run?
  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.save
    @blank_comment = @commentable.comments.new
  end

  # I still have not written any gangsta code
  def update
    # write some gangsta code here
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.replies.any?
      comment.replies.destroy_all
    end
    comment.destroy
    render nothing: true
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
