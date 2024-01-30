Rails.application.routes.draw do

  devise_for :users
  root to: 'questions#index'
  delete 'links/:id/destroy', to: 'links#destroy', as: 'destroy_link'
  delete 'attachments/:id/purge', to: 'attachments#purge', as: 'purge_attachment'

  resources :badges, only: :index
  resources :questions do
    resources :answers, shallow: true, except: %i[new index]
  end
end
