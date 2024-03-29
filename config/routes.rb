Rails.application.routes.draw do

  #顧客用
  devise_for :endusers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #ゲストログイン用
  devise_scope :enduser do
    post 'endusers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  #管理者用
  devise_for :admin, skip: [:registrations, :passswords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: 'public' do
    root to: 'homes#top'
    get '/about' => "homes#about", as: 'about'
    get 'posts/favorites'
    get 'posts/rank'
    resources :posts do
      resource :favorite, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :endusers, only: [:show, :edit, :update]
  end

  namespace :admin do
    get 'homes/top'
    resources :categories, only: [:index, :create, :edit, :update]
    resources :endusers, only: [:index, :show, :edit, :update]
    resources :posts, only: [:show, :update] do
      resources :post_comments, only: [:destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
