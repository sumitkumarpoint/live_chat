class OnlineUsersJob < ApplicationJob
  queue_as :default

  def perform(args)
    current_login_user=args[:current_user]
    if current_login_user
      current_login_user.online = args[:online]
      current_login_user.save!
      online_user_ids= User.where(online: true).pluck(:id)
      ActionCable.server.broadcast "appearance", {
          user:  current_login_user.id, online: :on,
          online_user_ids: online_user_ids,
          users: (online_user_ids.length-1)
      }

    end
  end
end
