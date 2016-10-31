# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EntriesController do
  fixtures(:all)

  let(:blog) { Blog.first }
  let(:first_entry) { blog.entries.first }

  describe 'GET #show' do
    it '@entry に entry が入っていること' do
      get :show, params: { blog_id: blog, id: first_entry }
      expect(assigns(:entry)).to eq first_entry
    end

    it '親子関係が一致しない URL に移動したらリダイレクトされること' do
      other_blog_entry = entries(:other_blog)
      get :show, params: { blog_id: blog, id: other_blog_entry }
      expect(response).to redirect_to blog
    end
  end

  describe 'GET #new' do
    it '@entry に Entry のインスタンスが入っていること' do
      get :new, params: { blog_id: blog }
      entry = assigns(:entry)
      expect(entry.class).to eq Entry
      expect(entry).to_not be_persisted
    end
  end

  describe 'GET #edit' do
    it '@entry に Entry のインスタンスが入っていること' do
      get :edit, params: { blog_id: blog, id: first_entry }
      expect(assigns(:entry).class).to eq Entry
    end
  end

  describe 'POST #create' do
    it 'POST すると記事がの数が増えること' do
      entry_params = { title: 'hoge', body: 'fuga' }
      expect { post :create, params: { blog_id: blog, entry: entry_params } }.to change { Entry.count }.by(+1)
    end

    it '作成後にその記事にリダイレクトされること' do
      post :create, params: { blog_id: blog, entry: { title: 'hoge', body: 'fuga' } }
      expect(response).to redirect_to([blog, Entry.last])
    end
  end

  describe 'PATCH #update' do
    before do
      @entry = first_entry
      expect(@entry.title).to_not be 'hoge'
      patch :update, params: { blog_id: 1, id: @entry, entry: { title: 'hoge', body: @entry.body } }
      @entry.reload
    end

    it '更新されること' do
      expect(@entry.title).to eq 'hoge'
    end

    it '更新された後にその Entry に移動すること' do
      expect(response).to redirect_to([@entry.blog, @entry])
    end
  end
end
