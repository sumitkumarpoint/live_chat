class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:chat_room_id]}"
  end

  def unsubscribed
  end
end
