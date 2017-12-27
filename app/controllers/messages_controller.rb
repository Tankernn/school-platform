class MessagesController < ApplicationController

  def create
    @conversation = Conversation.find(params[:conversation_id])
    if current_user.conversations.include? @conversation
      @message = current_user.messages.build(message_params)
      @message.conversation = @conversation
      if @message.save
        flash[:success] = "Message posted successfully"
        redirect_to @conversation
      else
        render @conversation
      end
    else
      flash[:danger] = "You are not part of this conversation"
      redirect_to root_path
    end
  end

  private
    def message_params
      params.require(:message).permit(:content)
    end
end
