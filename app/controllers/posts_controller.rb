class PostsController < ApplicationController

  before_action :author?, only: [:edit, :update]

  def new
    @post = Post.new
    #@sub = Sub.find(post_params[:sub_id])
    render :new
  end

  def edit
    @post = Post.find(params[:id])
    # @sub = @post.sub
    render :edit
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      params[:post][:sub_ids].each do |sub_id|
        PostSub.create!(post_id: @post.id, sub_id: sub_id)
      end


      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(post_params)

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @sub = @post.sub
    @post.destroy
    redirect_to sub_url(@sub)
  end

  def index
    @posts = Sub.find(params[:id]).posts
    render :index
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_ids)
  end

  def author?
    @post = Post.find(params[:id])
    if current_user.id != @post.user_id
      redirect_to sub_url(Sub.find(@post.sub_id))
    end
  end

end
