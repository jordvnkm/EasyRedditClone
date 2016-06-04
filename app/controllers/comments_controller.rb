class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    unless params[:comment_id].empty?
      @comment.commentable_id = params[:comment_id]
      @comment.commentable_type = "Comment"
      @comment.parent_comment_id = params[:comment_id]
    else
      @comment.commentable_id = params[:post_id]
      @comment.commentable_type = "Post"
      @comment.parent_comment_id = nil
    end

    if @comment.save
      if @comment.commentable_type == "Comment"
        # comment = @comment
        # until comment.parent_comment_id.nil?
        #   comment = Comment.find(comment.parent_comment_id)
        # end
        # redirect_to post_url(Post.find(comment.commentable_id))
        redirect_to post_url(Post.find(@comment.parent.commentable_id))
      else
        redirect_to post_url(Post.find(@comment.commentable_id))
      end
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
