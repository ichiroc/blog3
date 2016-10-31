# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Blog do
  scenario 'Blogの新規作成時にtitleを入力しなかった場合にエラーが表示されること' do
    visit blogs_path
    click_link 'New Blog'
    click_button 'Submit'
    expect(page).to have_content "Title can't be blank"
  end

  scenario 'Blogの新規作成時にtitleを入力した場合はデータが保存され閲覧画面に遷移すること' do
    visit blogs_path
    click_link 'New Blog'
    fill_in 'Title', with: 'hoge'
    expect { click_button 'Submit' }.to change(Blog, :count).by(+1)
  end
end
