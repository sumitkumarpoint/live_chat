class ChatRoomsController < ApplicationController
  def create
    current_user_subscriptions=current_user.subscriptions.pluck(:chat_room_id)
    other_user_subscriptions=Subscription.where(:user_id=>params[:user_id]).pluck(:chat_room_id)
    chat_room_ids= (current_user_subscriptions & other_user_subscriptions)
    if chat_room_ids.length == 0
      @chat_room = ChatRoom.new
      if @chat_room.save
        @chat_room.subscriptions.create([{:user_id => current_user.id},{:user_id => params[:user_id]}])
        redirect_to chat_path(:chat_room_id=>@chat_room.id)
      end
    else
      redirect_to chat_path(:chat_room_id=>chat_room_ids[0])
    end
  end
  private
  def modal_params
    params.require(:chat_room).permit(:title ,:subscriptions_attributes=> [:user_id])
  end
end
