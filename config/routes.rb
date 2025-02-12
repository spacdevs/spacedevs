# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'dashboard#index'

  resource  :session,   only: %i[new create destroy]
  resources :passwords, param: :token
  resource  :profile, only: %i[show edit update], path: :perfil
  resolve('Profile') { [ :profile ] }


  resources :disciplines, only: %i[show], param: :slug, path: :disciplina do
    resources :contents, only: %i[show], param: :content_slug, path: :aula
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
