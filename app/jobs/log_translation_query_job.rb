class LogTranslationQueryJob < ApplicationJob
  queue_as :log

  def perform(input_text, input_language, output_text, output_language, doc_type, error_status)
    Translation.log_trans_query(
      input_text, 
      input_language, 
      output_text, 
      output_language, 
      doc_type, 
      error_status
    )
  end
end