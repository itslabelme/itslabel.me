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

      english_phrase = hsh[:english_phrase].to_s.strip
      arabic_phrase = hsh[:arabic_phrase].to_s.strip
      french_phrase = hsh[:french_phrase].to_s.strip
      #input_language = hsh[:input_language].to_s.strip

      #output_phrase = hsh[:output_phrase].to_s.strip
      #output_language = hsh[:output_language].to_s.strip
      category = hsh[:category].to_s.strip
      
      #translation = Translation.where(input_phrase: input_phrase, output_phrase: output_phrase, input_language: input_language, output_language: output_language).first
      translation = Translation.where(english_phrase: english_phrase, arabic_phrase: arabic_phrase, french_phrase: french_phrase).first
      # if input_language.eql('English')
      #   translation = Translation.where(english_phrase: english_phrase).first
      # elsif input_language.eql('Arabic')
      #   translation = Translation.where(arabic_phrase: arabic_phrase).first
      # elsif input_language.eql('French')
      #   translation = Translation.where(french_phrase: french_phrase).first
      # end
        
        
      if translation
        # puts "#{input_phrase} (#{input_language}) => #{output_phrase} (#{output_language})".yellow
      else
        translation = Translation.new
      end
          
      translation.admin_user_id = admin_user.id if admin_user
      translation.english_phrase = english_phrase
      translation.arabic_phrase = arabic_phrase
      translation.french_phrase = french_phrase
      #translation.input_language = input_language

      #translation.output_phrase = output_phrase
      #translation.output_language = output_language
      translation.category = category if category


      if translation.valid?
	      begin
          translation.save!
	      rescue StandardError => e
	        summary = "uncaught #{e} exception while handling connection: #{e.message}"
	        details = "Stack trace: #{e.backtrace.map {|l| "  #{l}\n"}.join}"
	        error_object.errors << { summary: summary, details: details }        
	      end
	    else
	      summary = "Error while saving yojana_translations: #{translation.english_phrase} "
	      details = "Error! #{translation.errors.full_messages.to_sentence}"
	      error_object.errors << { summary: summary, details: details }
	    end
	    return error_object
	  end
    # :nocov:
    
  end
  
end