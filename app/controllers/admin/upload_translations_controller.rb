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
      @summary = {}
      @parsing_status = {total_rows: 0, num_missing_rows: 0, missed_rows: []}
      
      if csv_file
        begin
          @path=csv_file.path
          @csv_contents = CSV.read(csv_file.path)
         rescue
          file_error = "Unable to read the contents of the uploaded file, Please upload valid file"
        end
      else
        file_error = "CSV file not uploaded"
      end

      if file_error.blank? && @csv_contents
        csv_save
        import_data_from_csv
        upload_history
        upload_summary
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
        begin
          add_english_to_arabic_translation(csv_content)
          add_english_to_french_translation(csv_content)
          add_arabic_to_english_translation(csv_content)
          add_arabic_to_french_translation(csv_content)
          add_french_to_english_translation(csv_content)
          add_french_to_arabic_translation(csv_content)
        rescue StandardError => e
          error = "uncaught #{e} exception while handling connection: #{e.message}"
          puts "CSV Content: #{csv_content}"
          puts "Error: #{error}"
        end
      end

    end

    def add_english_to_arabic_translation(csv_content)
      @english_arabic_translation = Translation.where(
        input_language: "ENGLISH", 
        output_language: "ARABIC",
        input_phrase: csv_content[0],
        output_phrase: csv_content[1]
        ).first
      @english_arabic_translation ||= Translation.new(
        input_language: "ENGLISH", 
        output_language: "ARABIC",
        input_phrase: csv_content[0], 
        output_phrase: csv_content[1], 
        category: csv_content[3],
        admin_user: @current_admin_user,
        status: "APPROVED"

      )
      
      if @english_arabic_translation.valid?
        if @english_arabic_translation.save
          @summary[csv_content[0]] ||= {}
          @summary[csv_content[0]]['english-arabic'] ||= true
        end
      else
        @summary[csv_content[0]]['english-arabic'] = @english_arabic_translation.errors.full_messages
      end
    end

    def add_english_to_french_translation(csv_content)
      @english_french_translation = Translation.where(
          input_language: "ENGLISH", 
          output_language: "FRENCH",
          input_phrase: csv_content[0],
          output_phrase: csv_content[2], 
          ).first
      @english_french_translation ||= Translation.new(
        input_language: "ENGLISH", output_language: "FRENCH",
        input_phrase: csv_content[0], 
        output_phrase: csv_content[2], 
        category: csv_content[3],
        admin_user: @current_admin_user,
        status: "APPROVED"
      )

      if @english_french_translation.valid?
        if @english_french_translation.save
          @summary[csv_content[0]] ||= {}
          @summary[csv_content[0]]['english-french'] = true
        end
      else
        @summary[csv_content[0]]['english-french'] = @english_french_translation.errors.full_messages
      end
    end

    def add_arabic_to_english_translation(csv_content)
      @arabic_english_translation = Translation.where(
          input_language: "ARABIC", 
          output_language: "ENGLISH",
          input_phrase: csv_content[1],
          output_phrase: csv_content[0]
          ).first

      @arabic_english_translation ||= Translation.new(
        input_language: "ARABIC", output_language: "ENGLISH",
        input_phrase: csv_content[1], 
        output_phrase: csv_content[0], 
        category: csv_content[3],
        admin_user: @current_admin_user,
        status: "APPROVED"
      )

      if @arabic_english_translation.valid?
        if @arabic_english_translation.save
          @summary[csv_content[0]] ||= {}
          @summary[csv_content[0]]['arabic-english'] = true
        end
      else
        @summary[csv_content[0]]['arabic-english'] = @arabic_english_translation.errors.full_messages
      end
    end

    def add_arabic_to_french_translation(csv_content)
      @arabic_french_translation = Translation.where(
          input_language: "ARABIC", 
          output_language: "FRENCH",
          input_phrase: csv_content[1],
          output_phrase: csv_content[2]
          ).first

      @arabic_french_translation ||= Translation.new(
        input_language: "ARABIC", output_language: "FRENCH",
        input_phrase: csv_content[1], 
        output_phrase: csv_content[2], 
        category: csv_content[3],
        admin_user: @current_admin_user,
        status: "APPROVED"
      )

      if @arabic_french_translation.valid?
        if @arabic_french_translation.save
          @summary[csv_content[0]] ||= {}
          @summary[csv_content[0]]['arabic-french'] = true
        end
      else
        @summary[csv_content[0]]['arabic-french'] = @arabic_french_translation.errors.full_messages
      end
    end

    def add_french_to_english_translation(csv_content)
      @french_english_translation = Translation.where(
          input_language: "FRENCH", 
          output_language: "ENGLISH",
          input_phrase: csv_content[2],
          output_phrase: csv_content[0]
          ).first 

      @french_english_translation ||= Translation.new(
        input_language: "FRENCH", output_language: "ENGLISH",
        input_phrase: csv_content[2], 
        output_phrase: csv_content[0], 
        category: csv_content[3],
        admin_user: @current_admin_user,
        status: "APPROVED"
      )

      if @french_english_translation.valid?
        if @french_english_translation.save
          @summary[csv_content[0]] ||= {}
          @summary[csv_content[0]]['french-english'] = true
        end
      else
        @summary[csv_content[0]]['french-english'] = @french_english_translation.errors.full_messages
      end
    end

    def add_french_to_arabic_translation(csv_content)
      @french_arabic_translation = Translation.where(
          input_language: "FRENCH", 
          output_language: "ARABIC",
          input_phrase: csv_content[2],
          output_phrase: csv_content[1]
          ).first

      @french_arabic_translation ||= Translation.new(
        input_language: "FRENCH", 
        output_language: "ARABIC",
        input_phrase: csv_content[2], 
        output_phrase: csv_content[1], 
        category: csv_content[3],
        admin_user: @current_admin_user,
        status: "APPROVED"
      )

      if @french_arabic_translation.valid?
        if @french_arabic_translation.save
          @summary[csv_content[0]] ||= {}
          @summary[csv_content[0]]['french-arabic'] = true
        end
      else
        @summary[csv_content[0]]['french-arabic'] = @french_arabic_translation.errors.full_messages
      end
    end
    def csv_save
      @cdate=DateTime.now.strftime '%d.%m.%Y__%3N'
      CSV.open("#{Rails.root}/public/imported_files/template_#{@cdate}.csv", "wb") do |csv|  
        @csv_contents.each do |csv_content|
         csv << [csv_content[0],csv_content[1],csv_content[2],csv_content[3]]
        end
      end 
    end

    def upload_history
      @history=UploadsHistory.new(admin_user:current_admin_user.first_name,file_path:"template_#{@cdate}.csv")
      @history.save 
    end
    
    def upload_summary
      @summ=UploadsSummary.new(translation_uploads_history_id:@history.id,summary_new:@summary)
      @summ.save
    end
  end
end
