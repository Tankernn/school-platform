class ConversationsController < ApplicationController

  before_action :set_conversation, only: [:show]
  before_action :check_permission, only: [:show]

  def show
  end

  private
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    def check_permission
      unless current_user.conversations.include? @conversation
        flash[:danger] = "You are not part of this conversation"
        redirect_to root_path
      end
    end

    def conversation_params
      params.require(:conversation).permit(:name, messages_attributes: [:content])
    end
end
