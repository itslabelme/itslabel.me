module Admin
  class UploadTranslationsController < Admin::BaseController

    require 'csv'

    # before_action :authenticate_admin_user!
    # before_action :get_translation, except: [:new, :create, :index]

    def index
      @page_title = "Upload Translation Data"
      @nav = 'admin/translations'
      # new_translation
    end

    def create
      
      # binding.pry

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
      @csv_contents.each do |csv_content|
      binding.pry

        # English to Arabic Translation
        @english_arabic_translation = Translation.new(
          input_language: "ENGLISH", ourput_language: "ARABIC",
          input_phrase: csv_content.english_phrase, 
          output_phrase: csv_content.arabic_phrase, 
          category: csv_content.category,
          admin_user: @current_client_user
        )

        # English to French Translation
        @english_french_translation = Translation.new(
          input_language: "ENGLISH", ourput_language: "FRENCH",
          input_phrase: csv_content.english_phrase, 
          output_phrase: csv_content.french_phrase, 
          category: csv_content.category,
          admin_user: @current_client_user
        )

        # Arabic to English Translation
        @english_arabic_translation = Translation.new(
          input_language: "ARABIC", ourput_language: "ENGLISH",
          input_phrase: csv_content.arabic_phrase, 
          output_phrase: csv_content.english_phrase, 
          category: csv_content.category,
          admin_user: @current_client_user
        )

        # Arabic to French Translation
        @arabic_french_translation = Translation.new(
          input_language: "ARABIC", ourput_language: "FRENCH",
          input_phrase: csv_content.arabic_phrase, 
          output_phrase: csv_content.french_phrase, 
          category: csv_content.category,
          admin_user: @current_client_user
        )

        # French to English Translation
        @french_english_translation = Translation.new(
          input_language: "FRENCH", ourput_language: "ENGLISH",
          input_phrase: csv_content.french_phrase, 
          output_phrase: csv_content.english_phrase, 
          category: csv_content.category,
          admin_user: @current_client_user
        )

        # French to Arabic Translation
        @french_arabic_translation = Translation.new(
          input_language: "FRENCH", ourput_language: "ARABIC",
          input_phrase: csv_content.french_phrase, 
          output_phrase: csv_content.arabic_phrase, 
          category: csv_content.category,
          admin_user: @current_client_user
        )

        if @english_arabic_translation.valid?
          if @english_arabic_translation.save
            @summary[csv_content.english_phrase] ||= {}
            @summary[csv_content.english_phrase][:arabic] ||= true
          end
        else
          @errors[csv_content.english_phrase] ||= {}
          @errors[csv_content.english_phrase][:arabic] = @english_arabic_translation.errors.full_messages
        end

        if @english_french_translation.valid?
          if @english_french_translation.save
            @summary[csv_content.english_phrase] ||= {}
            @summary[csv_content.english_phrase][:french] = true
          end
        else
          @errors[csv_content.english_phrase] = @english_french_translation.errors.full_messages
        end

        if @english_arabic_translation.valid?
          if @english_arabic_translation.save
            @summary[csv_content.english_phrase] ||= {}
            @summary[csv_content.english_phrase][:arabic] = true
          end
        else
          @errors[csv_content.english_phrase] = @english_arabic_translation.errors.full_messages
        end

        if @arabic_french_translation.valid?
          if @arabic_french_translation.save
            @summary[csv_content.english_phrase] ||= {}
            @summary[csv_content.english_phrase][:arabic_french] = true
          end
        else
          @errors[csv_content.english_phrase] = @arabic_french_translation.errors.full_messages
        end

        if @french_english_translation.valid?
          if @french_english_translation.save
            @summary[csv_content.english_phrase] ||= {}
            @summary[csv_content.english_phrase][:french_english] = true
          end
        else
          @errors[csv_content.english_phrase] = @french_english_translation.errors.full_messages
        end

        if @french_arabic_translation.valid?
          if @french_arabic_translation.save
            @summary[csv_content.english_phrase] ||= {}
            @summary[csv_content.english_phrase][:french_arabic] = true
          end
        else
          @errors[csv_content.english_phrase] = @french_arabic_translation.errors.full_messages
        end

      end

    end



    private


    
    def get_collection
       
      @order_by = "created_at DESC" unless @order_by

      @relation = Translation.where("")

      apply_filters
      
      @translations = @relation.
                        order(@order_by).
                        page(@current_page).per(@per_page)
    end
    
  

    def get_translation
      @translation = Translation.find_by_id(params[:id])
    end

    def new_translation
      @translation = Translation.new
    end

  end
end
