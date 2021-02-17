class UserMailerNotification < ApplicationMailer
  def send_welcome_email(user)
   	@client_user = user
   	mail( :to => @client_user.email,
    			:subject => 'Thanks for signing up for our amazing ITS app' )
  end
 end