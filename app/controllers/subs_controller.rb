class SubsController < ApplicationController

  before_action :ensure_moderator_is_current_user, only: [:edit, :update]

  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    @sub.update_attributes(sub_params)

    if @sub.save
      redirect_to sub_url
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def ensure_moderator_is_current_user
    @sub = Sub.find(params[:id])
    if @sub.user_id == current_user.id
      return true
    else
      redirect_to sub_url(@sub)
    end
  end

end
