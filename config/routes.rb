# frozen_string_literal: true

Rails.application.routes.draw do
  resources :news
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :news, defaults: { format: :json }
    end
  end
end
