class UserNotifierMailer < ApplicationMailer
	def send_signup_email(user)
    @client_user = user
    mail( :to => @client_user.email,
    :subject => 'Thanks for signing up for our amazing app' )
  end
end