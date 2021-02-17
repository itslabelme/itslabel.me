module Itslabel::LogMethods
  
  extend ActiveSupport::Concern

  class_methods do

    def log_trans_query(input_text, input_language, output_text, output_language, doc_type, error_status)
      translation = TranslationQueryHistory.new(
        input_language: input_language || 'Default', 
        output_language: output_language || 'Default',
        input_phrase: input_text || 'Default', 
        output_phrase: output_text || 'Default', 
        error: error_status || false,
        error_message: output_text || 'Default',
        client_user: @current_client_user,
        doc_type: doc_type,
        status: "ACTIVE"
      )
      if translation.valid?
        translation.save
      end
    end

  end

end