# frozen_string_literal: true
Rails.application.routes.draw do
  root 'blog#index'
  resources :blogs do
    resources :entries, except: [:index] do
      resources :comments, only: [:new, :create, :approve, :destroy] do
        member do
          patch 'approve'
        end
      end
    end
  end
end
