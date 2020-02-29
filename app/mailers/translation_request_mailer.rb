class TranslationRequestMailer < ApplicationMailer
  def send_mail(options={})
    @phrase = options[:phrase]
    @client = options[:client]
    @input_language = options[:input_language]
    @output_language = options[:output_language]
    
    mail(:to=>"krishna@rightsolutions.ae", 
         :subject=>"Translation Request - #{@phrase}")
  end
end
