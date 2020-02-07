Rails.application.routes.draw do
  devise_for :users
  root 'chats#index'
  match '/chat/:chat_room_id', to: 'chats#live_chat', :as => :chat, via: [:get, :post]
  get "/search_users" => "users#search_users", :as => :search_users
  get "/chat_room/:user_id" => "chat_rooms#create" ,:as=>:chat_room
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
