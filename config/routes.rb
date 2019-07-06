# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "static_pages#index"

  devise_for :users, controllers: {
                                              sessions: 'users/sessions',
                                              confirmations: 'users/confirmations',
                                              registrations: 'users/registrations'
                                            }

  resources :tenants
  resources :proprietors, except: %i[ index]

  namespace :proprietors do
    resources :homes do
    resources :appointments
    end
  end

  resources :invites


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
