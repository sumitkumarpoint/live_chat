class ChatsController < ApplicationController
  def index
    @chat=Chat.new
    if request.post?
      @chat=Chat.new(modal_params)
      @chat.save
      ActionCable.server.broadcast "chat",{
          message: ChatsController.render(
              partial: "message"
          ).squish
      }
    end

  end

  private
  def modal_params
    params.require(:chat).permit(:message)
  end
end
