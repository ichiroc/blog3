# frozen_string_literal: true
class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  def index
    @blogs = Blog.all
  end

  def show
  end

  def create
    @blog = Blog.new blog_params
    if @blog.save
      redirect_to @blog, notice: 'Successfully blog created.'
    else
      render :new
    end
  end

  def new
    @blog = Blog.new
  end

  def update
    if @blog.update_attributes blog_params
      redirect_to @blog, notice: 'Successfully blog updated.'
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    if @blog.destroy
      redirect_to @blog, notice: 'Successfully blog destroyed.'
    else
      redirect_to @blog, notice: 'Something went wrong!'
    end
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title)
  end
end
