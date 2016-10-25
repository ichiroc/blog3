# coding: utf-8
# frozen_string_literal: true
class EntriesController < ApplicationController
  before_action :set_entry, only: [:edit, :show, :update, :destroy]
  before_action :check_blog, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @entry = Entry.new(blog_id: params[:blog_id])
    @entry.blog = Blog.find(params[:blog_id]) # 確実に存在する Blog に限定する
  end

  def create
    entry = Entry.new(entry_params.merge(blog_id: params[:blog_id]))
    if entry.save
      redirect_to [entry.blog, entry], notice: 'Successfully Entry created.'
    else
      redirect_to blog_path(params[:blog_id]), notice: 'Something went wrong!'
    end
  end

  def edit
  end

  def update
    if @entry.update(entry_params)
      redirect_to [@entry.blog, @entry], notice: 'Successfully Entry updated.'
    else
      redirect_to [@entry.blog, @entry], notice: 'Something went wrong!'
    end
  end

  def destroy
    if @entry.destroy
      redirect_to @entry.blog, notice: 'Successfully Entry destroyed.'
    else
      redirect_to @entry.blog, notice: 'Something went wrong!'
    end
  end

  private

  def check_blog
    blog = Blog.find(params[:blog_id])
    entry = Entry.find(params[:id])
    redirect_to blog, notice: 'Entry not found.' unless entry.blog == blog
  end

  def set_entry
    @entry = Entry.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:title, :body)
  end
end
