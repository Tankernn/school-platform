class ConversationParticipationsController < ApplicationController

  before_action :set_conversation
  before_action :check_permissions, only: :create

  def create
    @participation = ConversationParticipation.create(participation_params)
    if @participation.save
      flash[:success] = "Added user to conversation"
    end
    redirect_to @conversation
  end

  private
    def participation_params
      params.require(:conversation_participation).permit(:conversation_id,
                                                         :user_id)
    end

    def set_conversation
      @conversation = Conversation.find(participation_params[:conversation_id])
    end

    def check_permissions
      unless current_user.conversations.include? @conversation
        flash[:danger] = "You are not part of this conversation"
        redirect_to root_path
      end
    end

end
