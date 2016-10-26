# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Blog do
  before do
    @blog = Blog.new()
  end

  it 'titleがあれば有効な状態であること' do
    @blog.title = 'hoge'
    expect(@blog.valid?).to be_truthy
  end

  it 'titleがなければ無効な状態であること' do
    expect(@blog.valid?).to_not be_truthy
  end
end
