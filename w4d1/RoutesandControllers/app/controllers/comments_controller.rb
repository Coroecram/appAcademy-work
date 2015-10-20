class CommentsController < ApplicationController
  def index
    Comments.all
  end

  def create
    comment = Comment.new(comment_params)
    render json: comment
  end

  private
  def comment_params
    params.require(:comment).permit(:body,:commentable_id)
  end

end
