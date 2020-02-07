class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    chat_path(:chat_room_id=>0)
  end

  def users_list
    @users = []
    if current_user.present?
      chat_room_ids = Subscription.where(:user_id => current_user.id).pluck(:chat_room_id)
      @users        = Subscription.select('users.email as email,users.id as user_id,subscriptions.chat_room_id as chat_room_id').left_joins(:user).where("chat_room_id in (?) AND user_id != ?", chat_room_ids, current_user.id)
    end
    return @users
  end
end
