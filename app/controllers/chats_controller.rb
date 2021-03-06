class ChatsController < ApplicationController
  before_action :check_if_logged_in

  def index
    @chats = @current_user.chats.order(updated_at: :desc)
    @language_select = LANGUAGES
    @chats.each do |chat|
      @language_select = @language_select.invert.reject!{|k,v| chat.language.include? k || @current_user.native_language == k}.invert
    end
    @language_select = @language_select.invert.reject{|k,v| @current_user.native_language == k}.invert
  end

  def create
    chat = Chat.create :language => params[:language]
    @current_user.chats << chat
    render :json => chat #send back a json object to the browser
  end

  def show
    @chat = Chat.find params[:id]
    @chat_messages = @chat.messages.order(:created_at)
    unless @current_user.chats.include? @chat
      redirect_to chats_path # redirect user to their own chats path if they try to go into someone elses
    end
  end

  def destroy
    chat = Chat.find params[:id]
    chat.destroy
    render :text => "I'm afraid he has The Knack." # Thanks Joel #render nothing because you dont need to render JSON
  end
end