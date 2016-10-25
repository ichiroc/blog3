# frozen_string_literal: true
class BlogsController < ApplicationController
  before_action :set_blog, only: [ :edit, :update, :destroy]
  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.where("id = #{params[:id]}").first
  end

  def create
    blog = Blog.new blog_params
    if blog.save
      redirect_to blog, notice: 'Successfully blog created.'
    else
      redirect_to blogs_path, notice: 'Something went wrong!'
    end
  end

  def new
    @blog = Blog.new
  end

  def update
    if @blog.update_attributes blog_params
      redirect_to @blog, notice: 'Successfully blog updated.'
    else
      redirect_to @blog, notice: 'Something went wrong!'
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
