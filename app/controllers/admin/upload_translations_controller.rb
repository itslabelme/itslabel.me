module Admin
  class UploadTranslationsController < Admin::BaseController

    require 'csv'

    def index
      @page_title = "Upload Translation Data"
      @nav = 'admin/translations'
      @errors = {}
      @summary = {}
    end

    def create
      csv_file = params[:file]
      file_error = nil
      @csv_contents = nil

      if csv_file
        begin
          @csv_contents = CSV.read(csv_file.path)
        rescue
          file_error = "Unable to read the contents of the uploaded file"
        end
      else
        file_error = "CSV file not uploaded"
      end

      if file_error.blank? && @csv_contents
        import_data_from_csv
      end
        set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "Translation"))
        set_flash_message(I18n.translate("success.created", item: "Translation"), :success)
    end

    def import_data_from_csv

      @errors = {}
      @summary = {}
      @csv_contents = @csv_contents.drop(1)
      
      # binding.pry

      @csv_contents.each do |csv_content|

        # English to Arabic Translation
        @english_arabic_translation = Translation.where(
                                                        input_language: "ENGLISH", 
                                                        output_language: "ARABIC",
                                                        input_phrase: csv_content[0],
                                                        output_phrase: csv_content[1]
                                                        ).first || Translation.new(
          input_language: "ENGLISH", output_language: "ARABIC",
          # input_phrase: csv_content.english_phrase, 
          # output_phrase: csv_content.arabic_phrase, 
          # category: csv_content.category,
          input_phrase: csv_content[0], 
          output_phrase: csv_content[1], 
          category: csv_content[3],
          admin_user: @current_admin_user
        )

        # binding.pry

        # # English to French Translation
        @english_french_translation = Translation.where(
                                                        input_language: "ENGLISH", 
                                                        output_language: "FRENCH",
                                                        input_phrase: csv_content[0],
                                                        output_phrase: csv_content[2], 
                                                        ).first || Translation.new(
          input_language: "ENGLISH", output_language: "FRENCH",
          # input_phrase: csv_content.english_phrase, 
          # output_phrase: csv_content.french_phrase, 
          # category: csv_content.category,          
          input_phrase: csv_content[0], 
          output_phrase: csv_content[2], 
          category: csv_content[3],
          admin_user: @current_admin_user
        )

        # # Arabic to English Translation
        @arabic_english_translation = Translation.where(
                                                        input_language: "ARABIC", 
                                                        output_language: "ENGLISH",
                                                        input_phrase: csv_content[1],
                                                        output_phrase: csv_content[0]
                                                        ).first || Translation.new(
          input_language: "ARABIC", output_language: "ENGLISH",
          # input_phrase: csv_content.arabic_phrase, 
          # output_phrase: csv_content.english_phrase, 
          # category: csv_content.category,          
          input_phrase: csv_content[1], 
          output_phrase: csv_content[0], 
          category: csv_content[3],
          admin_user: @current_admin_user
        )

        # # Arabic to French Translation
        @arabic_french_translation = Translation.where(
                                                        input_language: "ARABIC", 
                                                        output_language: "FRENCH",
                                                        input_phrase: csv_content[1],
                                                        output_phrase: csv_content[2]
                                                        ).first || Translation.new(
          input_language: "ARABIC", output_language: "FRENCH",
          # input_phrase: csv_content.arabic_phrase, 
          # output_phrase: csv_content.french_phrase, 
          # category: csv_content.category,          
          input_phrase: csv_content[1], 
          output_phrase: csv_content[2], 
          category: csv_content[3],
          admin_user: @current_admin_user
        )

        # # French to English Translation
        @french_english_translation = Translation.where(
                                                        input_language: "FRENCH", 
                                                        output_language: "ENGLISH",
                                                        input_phrase: csv_content[2],
                                                        output_phrase: csv_content[0]
                                                        ).first || Translation.new(
          input_language: "FRENCH", output_language: "ENGLISH",
          # input_phrase: csv_content.french_phrase, 
          # output_phrase: csv_content.english_phrase, 
          # category: csv_content.category,          
          input_phrase: csv_content[2], 
          output_phrase: csv_content[0], 
          category: csv_content[3],
          admin_user: @current_admin_user
        )

        # # French to Arabic Translation
        @french_arabic_translation = Translation.where(
                                                        input_language: "FRENCH", 
                                                        output_language: "ARABIC",
                                                        input_phrase: csv_content[2],
                                                        output_phrase: csv_content[1]
                                                        ).first || Translation.new(
          input_language: "FRENCH", output_language: "ARABIC",
          # input_phrase: csv_content.french_phrase, 
          # output_phrase: csv_content.arabic_phrase, 
          # category: csv_content.category,          
          input_phrase: csv_content[2], 
          output_phrase: csv_content[1], 
          category: csv_content[3],
          admin_user: @current_admin_user
        )

        if @english_arabic_translation.valid?
          if @english_arabic_translation.save
            # @summary[csv_content.english_phrase] ||= {}
            # @summary[csv_content.english_phrase][:arabic] ||= true
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]][:arabic] ||= true
          end
        else
          # @errors[csv_content.english_phrase] ||= {}
          # @errors[csv_content.english_phrase][:arabic] = @english_arabic_translation.errors.full_messages
          @errors[csv_content[0]] ||= {}
          @errors[csv_content[0]][:arabic] = @english_arabic_translation.errors.full_messages
        end

        if @english_french_translation.valid?
          if @english_french_translation.save
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]][:french] = true
          end
        else
          @errors[csv_content[0]] = @english_french_translation.errors.full_messages
        end

        if @arabic_english_translation.valid?
          if @arabic_english_translation.save
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]][:arabic] = true
          end
        else
          @errors[csv_content[0]] = @arabic_english_translation.errors.full_messages
        end

        if @arabic_french_translation.valid?
          if @arabic_french_translation.save
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]][:arabic_french] = true
          end
        else
          @errors[csv_content[0]] = @arabic_french_translation.errors.full_messages
        end

        if @french_english_translation.valid?
          if @french_english_translation.save
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]][:french_english] = true
          end
        else
          @errors[csv_content[0]] = @french_english_translation.errors.full_messages
        end

        if @french_arabic_translation.valid?
          if @french_arabic_translation.save
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]][:french_arabic] = true
          end
        else
          @errors[csv_content[0]] = @french_arabic_translation.errors.full_messages
        end

      end

    end

  end
end
