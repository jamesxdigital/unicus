class UserMailer < ApplicationMailer

	def email_notification(user_to,user_from,subject,message)
		@subject = subject
		@message = message
        @user = user_to
        @user_from = user_from
        mail(to: @user.email,from: @user_from.email, subject: @subject)
	end
end
