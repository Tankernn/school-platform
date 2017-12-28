class ConversationsController < ApplicationController

  before_action :set_conversation, only: [:show]
  before_action :check_permission, only: [:show]

  def index
    @conversations = current_user.conversations.sort_by{
      |c| c.messages.last.created_at
    }
  end

  def show
    ConversationParticipation
      .where(user: current_user, conversation: @conversation)
      .update_all(viewed_at: Time.now)
  end

  def new
    @conversation = Conversation.new
    @conversation.messages.build
  end

  def create
    @conversation = Conversation.new(conversation_params)
    @conversation.messages.each{ |message| message.user = current_user }
    if @conversation.save
      for id in params[:conversation][:user_ids].uniq
        @conversation.users << User.find(id)
      end
      unless @conversation.users.include? current_user
        @conversation.users << current_user
      end

      if @conversation.save
        flash[:success] = "Created conversation"
        redirect_to @conversation
      else
        render :new
      end
    else
      render :new
    end
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
