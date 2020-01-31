Rails.application.routes.draw do
  devise_for :users
  root 'chats#index'
  post '/chat' =>  "chats#index",:as=>:chat
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
