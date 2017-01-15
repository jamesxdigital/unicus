class MessagesController < ApplicationController

    before_action :set_message, only: [:show, :edit, :update, :destroy]

    def show

      @sender = User.find_by_id(@message.sender_id)

    end

	def index
		@senders = Array.new
		@your_messages = Message.where(user_id: current_user.id).sorted

		@your_messages.each do |msg|
			user = User.find_by_id(msg.sender_id)

			if not user.nil?

				@senders << [msg.id,"#{user.givenname}  #{user.sn}"]
			end

			if msg.seen == false

				msg.seen = true

				if msg.save
					puts "msg(#{msg.id}) is now seen."
				else
					puts "msg(#{msg.id}) is seen BUT FAILED TO UPDATED SEEN STATUS."
				end
			end

		end # end of loop

	end

  # DELETE messages/...
  def destroy
    @message.destroy
    redirect_to messages_url, notice: 'Message was successfully destroyed.'
  end

	private

	def set_message
		@message = Message.find(params[:id])
	end
end
