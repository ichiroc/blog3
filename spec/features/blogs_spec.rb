# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Blog do
  before do
    # 最初にブログ作成画面を表示しておく
    visit blogs_path
    click_link 'New Blog'
  end

  scenario 'Blogの新規作成時にtitleを入力しなかった場合にエラーが表示されること' do
    click_button 'Submit'
    expect(page).to have_content "Title can't be blank"
  end

  scenario 'Blogの新規作成時にtitleを入力した場合はデータが保存され閲覧画面に遷移すること' do
    fill_in 'Title', with: 'hoge'
    expect { click_button 'Submit' }.to change(Blog, :count).by(+1)
    expect(current_path).to eq blog_path(Blog.last)
    expect(page).to have_content 'Successfully blog created.'
  end
end
