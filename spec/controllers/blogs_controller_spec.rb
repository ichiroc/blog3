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

  describe 'POST #create' do
    it '新規作成後に@blogのshowに遷移すること' do
      post :create, params: { blog: { title: 'hoge' } }
      @blog = assigns(:blog)
      expect(response).to redirect_to blog_path(@blog)
    end
  end
end
