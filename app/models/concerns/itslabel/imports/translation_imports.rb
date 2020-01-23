module Itslabel::Imports::TranslationImports
  
  extend ActiveSupport::Concern

  class_methods do
      
    # :nocov:
    def save_row_data(hsh)
	    # Initializing error hash for displaying all errors altogether
      # error_object = Panjara::Importer::ErrorHash.new
	    error_object = Importer::ErrorHash.new

      admin_user = AdminUser.find_by_email(hsh[:admin_user_email].to_s.strip)
      # puts "Admin User: #{hsh[:admin_user_email]} - not found".red unless admin_user
      # return error_object unless admin_user

      input_phrase = hsh[:input_phrase].to_s.strip
      input_description = hsh[:input_description].to_s.strip
      input_language = hsh[:input_language].to_s.strip

      output_phrase = hsh[:output_phrase].to_s.strip
      output_description = hsh[:output_description].to_s.strip
      output_language = hsh[:output_language].to_s.strip
      
      translation = Translation.where(input_phrase: input_phrase, output_phrase: output_phrase, input_language: input_language, output_language: output_language).first || Translation.new
          
      translation.admin_user_id = admin_user.id if admin_user
      translation.input_phrase = input_phrase
      translation.input_description = input_description
      translation.input_language = input_language

      translation.output_phrase = output_phrase
      translation.output_description = output_description
      translation.output_language = output_language


      if translation.valid?
	      begin
          translation.save!
	      rescue StandardError => e
	        summary = "uncaught #{e} exception while handling connection: #{e.message}"
	        details = "Stack trace: #{e.backtrace.map {|l| "  #{l}\n"}.join}"
	        error_object.errors << { summary: summary, details: details }        
	      end
	    else
	      summary = "Error while saving yojana_translations: #{translation.input_phrase} - #{translation.input_language} "
	      details = "Error! #{translation.errors.full_messages.to_sentence}"
	      error_object.errors << { summary: summary, details: details }
	    end
	    return error_object
	  end
    # :nocov:
    
  end
  
end