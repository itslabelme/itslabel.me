module Admin
  class UploadTranslationsController < Admin::BaseController

    require 'csv'

    def index
      @page_title = "Upload Translation Data"
      @nav = 'admin/translations'
      @errors = {}
      @summary = {}
      @parsing_status = {total_rows: 0, num_missing_rows: 0, missed_rows: []}
    end

    def create
      csv_file = params[:file]
      file_error = nil
      @csv_contents = nil
      @errors = {}
      @summary = {}
      @parsing_status = {total_rows: 0, num_missing_rows: 0, missed_rows: []}

      if csv_file
        begin
          @csv_contents = CSV.read(csv_file.path)
        rescue
          file_error = "Unable to read the contents of the uploaded file, Please upload valid file"
        end
      else
        file_error = "CSV file not uploaded"
      end

      if file_error.blank? && @csv_contents
        import_data_from_csv
      end

      if file_error.blank?
        set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "Translation"))
        set_flash_message(I18n.translate("success.created", item: "Translation"), :success)
      else
        set_notification(false, I18n.t('status.error'), file_error)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end

    def import_data_from_csv

      @csv_contents = @csv_contents.drop(1)

      @parsing_status[:total_rows] = @csv_contents.length
      @csv_contents.each do |csv_content|
        if csv_content.length == 4 && !csv_content.any?{ |e| e.nil? }

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
            admin_user: @current_admin_user,
            status: "ACTIVE"
          )

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
              # @summary[csv_content.english_phrase][English-Arabic] ||= true
              @summary[csv_content[0]] ||= {}
              @summary[csv_content[0]]['English-Arabic'] ||= true
            end
          else
            # @errors[csv_content.english_phrase] ||= {}
            # @errors[csv_content.english_phrase][English-Arabic] = @english_arabic_translation.errors.full_messages
            @errors[csv_content[0]] ||= {}
            @errors[csv_content[0]]['English-Arabic'] = @english_arabic_translation.errors.full_messages

          end

          if @english_french_translation.valid?
            if @english_french_translation.save
              @summary[csv_content[0]] ||= {}
              @summary[csv_content[0]]['English-French'] = true
            end
          else
            @errors[csv_content[0]] ||= {}
            @errors[csv_content[0]]['English-French'] = @english_french_translation.errors.full_messages
          end

          if @arabic_english_translation.valid?
            if @arabic_english_translation.save
              @summary[csv_content[0]] ||= {}
              @summary[csv_content[0]]['Arabic-English'] = true
            end
          else
            @errors[csv_content[0]] ||= {}
            @errors[csv_content[0]]['Arabic-English'] = @arabic_english_translation.errors.full_messages
          end

          if @arabic_french_translation.valid?
            if @arabic_french_translation.save
              @summary[csv_content[0]] ||= {}
              @summary[csv_content[0]]['Arabic-French'] = true
            end
          else
            @errors[csv_content[0]] ||= {}
            @errors[csv_content[0]]['Arabic-French'] = @arabic_french_translation.errors.full_messages
          end

          if @french_english_translation.valid?
            if @french_english_translation.save
              @summary[csv_content[0]] ||= {}
              @summary[csv_content[0]]['French-English'] = true
            end
          else
            @errors[csv_content[0]] ||= {}
            @errors[csv_content[0]]['French-English'] = @french_english_translation.errors.full_messages
          end

          if @french_arabic_translation.valid?
            if @french_arabic_translation.save
              @summary[csv_content[0]] ||= {}
              @summary[csv_content[0]]['French-Arabic'] = true
            end
          else
            @errors[csv_content[0]] ||= {}
            @errors[csv_content[0]]['French-Arabic'] = @french_arabic_translation.errors.full_messages
          end
        else
          @parsing_status[:num_missing_rows] = @parsing_status[:num_missing_rows] + 1
          csv_content[0].nil? ? @parsing_status[:missed_rows] << csv_content[1] : @parsing_status[:missed_rows] << csv_content[0]
        end
      end

    end

  end
end
