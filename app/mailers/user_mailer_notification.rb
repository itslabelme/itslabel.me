class UserMailerNotification < ApplicationMailer
	def send_welcome_email(user)
   	@client_user = user
   	mail( :to => @client_user.email,
    			:subject => 'Thanks for signing up for our amazing ITS app' )
  end
  def send_forgot_password(user,reset_password_token,reset_password_sent_at)
    @email = user
    @password_token = reset_password_token
    @password_sent_at = reset_password_sent_at
   	mail( :to => @email,
    			:subject => 'ITS-Reset Your Password' )
  end
 end