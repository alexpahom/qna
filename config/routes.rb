Rails.application.routes.draw do

  post 'ranks/create'
  devise_for :users
  root to: 'questions#index'
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
