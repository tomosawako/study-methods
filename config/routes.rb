Rails.application.routes.draw do

  namespace :admin do
    get 'posts/show'
    get 'posts/edit'
  end
  #顧客用
  devise_for :endusers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #管理者用
  devise_for :admin, skip: [:registrations, :passswords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: 'public' do
    root to: 'homes#top'
    get '/about' => "homes#about", as: 'about'
    resources :posts do
      resource :favorite, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :endusers, only: [:show, :edit, :update]
  end

  namespace :admin do
    resources :categories, only: [:index, :create, :edit, :update]
    resources :endusers, only: [:index, :show, :edit, :update]
    resources :posts, only: [:show, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
