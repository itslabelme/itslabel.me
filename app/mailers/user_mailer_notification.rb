class UserMailerNotification < ApplicationMailer
	def send_welcome_email(user)
   	@client_user = user
   	mail( :to => @client_user.email,
    			:subject => 'Thanks for signing up for our amazing ITS app' )
  end
  def send_forgot_password(user)
    @client_user = user
   	mail( :to => @client_user.email,
    			:subject => 'ITS-Reset Your Password' )
  end
end