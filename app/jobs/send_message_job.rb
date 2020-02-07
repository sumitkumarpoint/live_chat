class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(args)
    chats=args['chats']
    current_online_user=args['current_online_user']
    ActionCable.server.broadcast "chat_#{params[:chat_room_id]}", {
        message: ChatsController.render(partial: "message", :locals => {chats: chats, broadcast: true}).squish,
        current_user_id: current_online_user.id
    }
  end
end
