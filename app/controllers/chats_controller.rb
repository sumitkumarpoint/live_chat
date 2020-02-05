class ChatsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @users = []
    if current_user.present?
      chat_room_ids = Subscription.where(:user_id => current_user.id).pluck(:chat_room_id)
      @users        = Subscription.select('users.email as email,users.id as user_id,subscriptions.chat_room_id as chat_room_id').left_joins(:user).where("chat_room_id in (?) AND user_id != ?", chat_room_ids, current_user.id)
    end
  end

  def live_chat
    @chat = Chat.new
    @user = Subscription.select("users.email as email,users.id as user_id").left_joins(:user).where("chat_room_id=? AND user_id != ?", params[:chat_room_id], current_user.id).first
    if request.post?
      @chat = Chat.new(modal_params)
      if @chat.save
        @chats = chats
        ActionCable.server.broadcast "chat_#{params[:chat_room_id]}", {
            message: ChatsController.render(partial: "message", :locals => {chats: @chats, broadcast: true}).squish
        }
      end
    else
      @chats = chats
    end
    p "============"
    p @chats.ids.inspect
    p "============"
  end

  def chats
    @chats = Chat.where(:chat_room_id => params[:chat_room_id]).limit(5).order("created_at desc")
  end

  private

  def modal_params
    params.require(:chat).permit(:message, :chat_room_id, :user_id)
  end
end
