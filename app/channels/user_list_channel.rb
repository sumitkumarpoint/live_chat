class UserListChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_list"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
