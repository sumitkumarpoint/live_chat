Rails.application.routes.draw do
  devise_for :users
  root 'chats#index'
  match '/chat/:chat_room_id', to: 'chats#live_chat',:as=>:chat, via: [:get, :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
