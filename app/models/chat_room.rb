class ChatRoom < ApplicationRecord
  has_many :subscriptions
  has_many :chats
end
