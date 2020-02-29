class TranslationRequestMailerJob < ApplicationJob
  queue_as :translation_request_mailer

  def perform(phrase, client, input_language, output_language)
    TranslationRequestMailer.send_mail(
        phrase: phrase, 
        client: client, 
        input_language: input_language, 
        output_language: output_language).deliver
  end
end