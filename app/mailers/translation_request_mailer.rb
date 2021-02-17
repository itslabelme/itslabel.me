class TranslationRequestMailer < ApplicationMailer
  def send_mail(options={})
    @phrase = options[:phrase]
    @client = options[:client]
    @input_language = options[:input_language]
    @output_language = options[:output_language]

    if Rails.env.production?
      email = "info@itslabel.me"
    else
      email = "athira@rightsolutions.ae"
    end
    
    mail(:to=>email, 
         :subject=>"Translation Request - #{@phrase}")
  end
end
