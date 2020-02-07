class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "appearance"

    OnlineUsersJob.perform_later({online: true})
    if current_user
      OnlineUsersJob.perform_later({online: true,current_user: current_user})
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed

    if current_user
      OnlineUsersJob.perform_later({online: false,current_user: current_user})
    end
  end
end
