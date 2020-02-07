class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    chat_path(:chat_room_id=>0)
  end
end
