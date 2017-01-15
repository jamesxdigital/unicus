module MessagesHelper

	def getColor(message_type)
      if message_type == "rejection_notification"
      	return "background: #ffe6e6;"
      elsif message_type == "approval_notification"
      	return "background: #e6ffe6;"
      else
      	return ""
      end
	end
end
