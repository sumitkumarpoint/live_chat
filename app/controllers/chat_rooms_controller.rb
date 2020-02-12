class ChatRoomsController < ApplicationController
  def create
    current_user_subscriptions=current_user.subscriptions.pluck(:chat_room_id)
    other_user_subscriptions=Subscription.where(:user_id=>params[:user_id]).pluck(:chat_room_id)
    chat_room_ids= (current_user_subscriptions & other_user_subscriptions)
    if chat_room_ids.length == 0
      @chat_room = ChatRoom.new
      if @chat_room.save
        @chat_room.subscriptions.create([{:user_id => current_user.id},{:user_id => params[:user_id]}])
        Chat.create({message: "Hi" ,chat_room_id: @chat_room.id,user_id:current_user.id})
        redirect_to chat_path(:chat_room_id=>@chat_room.id)
        users        = Subscription.select('users.email as email,users.id as user_id,subscriptions.chat_room_id as chat_room_id').left_joins(:user).where("chat_room_id in (?)", @chat_room.id)

        user_list=""
        current_user_list=""
        users.each do |user|
          if user.user_id != current_user.id
            user_list=render_to_string(:partial=>'chats/users_list',:locals=>{users: [user]})
          else
            current_user_list=render_to_string(:partial=>'chats/users_list',:locals=>{users: [user]})
          end
        end


        user_ids=[params[:user_id].to_i,current_user.id]
        ActionCable.server.broadcast "user_list" ,{
            data: {users_list: user_list,"#{current_user.id.to_s}"=> current_user_list},
            user_ids: user_ids
        }
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
