Rails.application.routes.draw do
  #顧客用
  devise_for :endusers, skip: [:passwords], controller: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #管理者用
  devise_for :admins, skip: [:registrations, :passswords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
