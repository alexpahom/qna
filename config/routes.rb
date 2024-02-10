Rails.application.routes.draw do

  get 'email/new'
  post 'email/create'
  root to: 'questions#index'

  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }
  post 'ranks/create'
  delete 'links/:id/destroy', to: 'links#destroy', as: 'destroy_link'
  delete 'attachments/:id/purge', to: 'attachments#purge', as: 'purge_attachment'

  resources :badges, only: :index
  resources :comments, only: %i[new destroy]
  post 'comments/create'

  resources :questions do
    resources :answers, shallow: true, except: %i[new index]
  end

  mount ActionCable.server => '/cable'
end
