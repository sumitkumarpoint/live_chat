class ChatsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @users=users_list
  end

  def live_chat
    @chat = Chat.new
    @users=users_list
    if params[:chat_room_id].to_i > 0
      @user = Subscription.select("users.email as email,users.id as user_id").left_joins(:user).where("chat_room_id=? AND user_id != ?", params[:chat_room_id], current_user.id).first
      if request.post?
        @chat_data = Chat.new(modal_params)
        if @chat_data.save
          # SendMessageJob.perform_later({chats: @chats,current_user: current_user})
          ActionCable.server.broadcast "chat_#{params[:chat_room_id]}", {
              message: ChatsController.render(partial: "message", :locals => {chats: [@chat_data], broadcast: true}).squish,
              current_user_id: current_user.id
          }
        end
      else
        @chats = chats
        respond_to do |format|
          format.html
          format.js
        end
      end
    end
  end


  def chats
    @chats = Chat.where(:chat_room_id => params[:chat_room_id]).order("created_at desc").paginate(page: params[:page], per_page: 10)
  end

  private

  def modal_params
    params.require(:chat).permit(:message, :chat_room_id, :user_id,:attached_file)
  end
end
