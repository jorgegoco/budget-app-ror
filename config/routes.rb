Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: 'groups#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'home#index', as: :unauthenticated_root
  end

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :groups do
    resources :operations
  end
end
