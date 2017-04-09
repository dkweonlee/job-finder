class CommentsController < ApplicationController
  before_action :find_comment, only: [:show, :edit, :update, :destroy]
  before_action :find_post
  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new comment_params
    if @comment.save
      redirect_to @post, notice: "Awesome! You generated comment!"
    else
      render 'new', notice: "Oops, something went wrong! Sorry!"
    end
  end

  def edit
    if current_user.id == @comment.user_id
    else
      flash.now[:alert] = "Error, You are not an owner of this Comment"
      redirect_to @post
    end
  end

  def update
    if @comment.update comment_params
      redirect_to @post, notice: "Your comment was sucessfully updated!"
    else
      render 'edit'
    end
  end

  def destroy
    if current_user.id == @comment.user_id
      @comment.destroy
      redirect_to @post
    else
      flash.now[:alert] = "Error, You are not an owner of this Comment"
      redirect_to @post
    end
  end

  private
    def find_post
       @post = Post.find(params[:post_id])
     rescue ActiveRecord::RecordNotFound
       render "errors/not_found", status: :not_found
    end

    def comment_params
      params.require(:comment).permit(:comment, :post_id).merge(user_id: current_user.id)
    end

    def find_comment
      @comment = Comment.find(params[:id])
    end
end
