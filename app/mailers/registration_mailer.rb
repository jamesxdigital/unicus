class RegistrationMailer < ApplicationMailer

  def notify_register(user)
    @user = user
    @url = "http://team21.demo2.software-hut.org.uk"
    mail(to: user.email, subject: "You were successfully registered")
  end
end
