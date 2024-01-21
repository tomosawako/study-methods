Rails.application.routes.draw do

  namespace :public do
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
    get 'posts/new'
  end
  scope module: 'public' do
  root to: 'homes#top'
  get '/about' => "homes#about", as: 'about'
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

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
