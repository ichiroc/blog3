# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Blog do
  subject { Blog.new(title: title).valid? }

  context 'titleが有る場合' do
    let(:title) { 'hoge' }
    it { is_expected.to be_truthy }
  end

  context 'titleが無い場合' do
    let(:title) { nil }
    it { is_expected.to_not be_truthy }
  end
end
