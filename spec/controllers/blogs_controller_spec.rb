# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe BlogsController do
  fixtures(:all)

  describe 'GET #index' do
    it '@blogsに全てのBlogが入っていること' do
      get :index
      @blogs = assigns(:blogs)
      expect(@blogs.size).to be 2
    end
  end

  describe 'GET #show' do
    it '@blog にブログが入っていること' do
      blog = Blog.first
      get :show, params: { id: blog }
      @blog = assigns(:blog)
      expect(@blog).to eq blog
    end
  end

  describe 'POST #create' do
    it '新規作成後に@blogのshowに遷移すること' do
      post :create, params: { blog: { title: 'hoge' } }
      @blog = assigns(:blog)
      expect(response).to redirect_to blog_path(@blog)
    end
  end

  describe 'PATCH #update' do
    before do
      @blog = Blog.create(title: 'fuga')
      patch :update, params: { id: @blog.id, blog: { title: 'hoge' } }
      @blog.reload
    end

    it '更新時に@blogの属性が変更されている事' do
      expect(@blog.title).to eq 'hoge'
    end

    it '更新後に blog に遷移すること' do
      expect(response).to redirect_to blog_path(@blog)
    end
  end

  describe 'DELETE #destroy' do
    before do
      @blog = Blog.create(title: 'hoge')
    end
    it '削除すると消える事' do
      expect { post :destroy, params: { id: @blog } }.to change { Blog.count }.by(-1)
    end

    it '削除後に index に移動すること' do
      post :destroy, params: { id: @blog }
      expect(response).to redirect_to blogs_path
    end
  end
end
