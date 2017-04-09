class PostsController < ApplicationController
  before_action :find_post, only: [:show, :update, :destroy, :edit]
  before_action :all_comments, only: [:edit, :destroy, :show]
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params

    if @post.save!
      redirect_to @post, notice: "Hey, your post got saved!"
    else
      render "new", notice: "Oooops, something went wrong!"
    end
  end

  def show
  end

  def edit
    if current_user.id == @post.user_id
    else
      flash.now[:alert] = "Error, You are not an owner of this Post"
      render 'show'
    end
  end

  def update
    if @post.update post_params
      redirect_to @post, notice: "Your Post was sucessfully updated!"
    else
      render 'edit'
    end
  end

  def destroy
    if current_user.id == @post.user_id
      @post.destroy
      redirect_to posts_path
    else
      flash.now[:alert] = "Error, You are not an owner of this Post"
      render 'show'
    end
  end  

  private
  def post_params
    params.require(:post).permit(:name, :title, :descripition, :job_type, :level, :location).merge(user_id: current_user.id)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def all_comments
    @comments = @post.comments
  end
end