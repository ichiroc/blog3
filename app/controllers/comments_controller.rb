# frozen_string_literal: true
class CommentsController < ApplicationController
  before_action :set_comment, only: [:approve, :destroy]
  before_action :check_entry, only: [:approve, :destroy]
  def approve
    @comment.status = 'approved'
    if @comment.save
      redirect_to [@comment.entry.blog, @comment.entry], notice: 'Successfully comment approved'
    else
      redirect_to [@comment.entry.blog, @comment.entry], notice: 'Something went wrong!'
    end
  end

  def create
    comment = Comment.new(comment_params.merge(entry_id: params[:entry_id]))
    if comment.save
      redirect_to [comment.entry.blog, comment.entry], notice: 'Successfully comment created'
    else
      redirect_to [comment.entry.blog, comment.entry], notice: 'Something went wrong!'
    end
  end

  def destroy
    if @comment.destroy
      redirect_to [@comment.entry.blog, @comment.entry], notice: 'Successfully comment destroyed.'
    else
      redirect_to [@comment.entry.blog, @comment.entry], notice: 'Something went wrong!'
    end
  end

  private

  def check_entry
    blog = Blog.find(params[:blog_id])
    entry = Entry.find(params[:entry_id])
    comment = Comment.find(params[:id])
    if comment.entry != entry || entry.blog != blog
      redirect_to [comment.entry.blog, comment.entry], notice: 'Comment not found.'
    end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
