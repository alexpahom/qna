Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'
  delete 'attachments/:id/purge',to: 'attachments#purge', as: 'purge_attachment'

  resources :questions do
    resources :answers, shallow: true, except: %i[new index]
  end
end
