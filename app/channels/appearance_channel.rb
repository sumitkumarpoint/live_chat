class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "appearance"

    OnlineUsersJob.perform_later({online: true})
    if current_user
      OnlineUsersJob.perform_later({online: true,current_user: current_user})
    #   current_user.online = true
    #   current_user.save!
    #   online_user_ids= User.where(online: true).pluck(:id)
    #   ActionCable.server.broadcast "appearance", {
    #       user:  current_user.id, online: :on,
    #       online_user_ids: online_user_ids,
    #       users: (online_user_ids.length-1)
    #   }
    #
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed

    if current_user
      OnlineUsersJob.perform_later({online: false,current_user: current_user})

      #   current_user.online = false
    #   current_user.save!
    #   online_user_ids= User.where(online: true).pluck(:id)
    #   ActionCable.server.broadcast "appearance", {
    #       user:  current_user.id, online: :off,
    #       online_user_ids: online_user_ids,
    #       users:( online_user_ids.length-1)
    #   }
    end
  end
end
