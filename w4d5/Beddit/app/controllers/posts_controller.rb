class PostsController < ApplicationController

  before_action :is_post_author?, only: [:edit, :update, :destroy]
  before_action :is_logged_in?, only: [:new, :create]

  def index
    @posts = Post.all
    render text: "posts#index"
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def new
    @sub = Sub.find(params[:sub_id])
    @post = Post.new(sub_id: @sub.id, author_id: @sub.moderator_id)
    @author = User.find(@post.author_id)

    render :new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_url
    else

      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:sub_id])
    @post = Post.new(sub_id: @sub.id, author_id: @sub.moderator_id)
    @author = User.find(@post.author_id)

    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    @post
    redirect_to posts_url
  end

  def is_post_author?
    post = Post.find(params[:id])
    redirect_to posts_url unless current_user && current_user.id == post.author_id
  end

  def is_logged_in?
    redirect_to posts_url unless logged_in?
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :author_id, :sub_id, :url)
  end
end
