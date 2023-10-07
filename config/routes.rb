Rails.application.routes.draw do
  devise_for :users
  root to: "topics#index"
  resources :tags do
    member do
      get 'posts', to: 'tags#posts', as: 'posts'
    end
  end
  resources :topics do
    resources :posts do
      patch '/mark_post_as_read',on: :member, to: 'posts#mark_as_read'
      resources :comments
      resources :ratings
    end
  end
end
