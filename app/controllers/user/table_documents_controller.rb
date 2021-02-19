module User
  class TableDocumentsController < User::BaseController

    require 'csv'

    before_action :authenticate_client_user!
    before_action :get_document, except: [:new, :create, :index, :select_template]
    skip_before_action :verify_authenticity_token, :only => [:translate_input_phrase, :save_everything]
    #before_action :access_denied
    before_action :access_denied, only: [:index, :new]
    
    def index
      @page_title = "Documents (Table Mode)"
      @nav = 'user/table_documents'

      get_collection
    end

    def show
      get_document
      @document_folders = @current_client_user.document_folders
      @nav = 'user/table_documents'
      @page_title = @document.title

      # Redirect to show Page - only if you are on new page
      @redirect_to_show_page = false

      @document_items = @document.items
      num = 16 - @document_items.count
      num = 10 if num < 10 # show at least 10 extra columns
      num.times.each do |i|
        @document.items.build(
          temporary_key: "tkey-#{i}",
          input_language: @document.input_language,
          translated: false,
          output_1_language: @document.output_1_language,
          output_2_language: @document.output_2_language,
          output_3_language: @document.output_3_language,
          output_4_language: @document.output_4_language,
          output_5_language: @document.output_5_language,
        )
      end
    end

    def new
      @page_title = "New Document (Table Mode)"
      @nav = 'user/table_documents'
      
      @document_folders = @current_client_user.document_folders

      new_document

      @document_items = []
      no_of_rows = 100
      no_of_rows.times.each do |i|
        @document_items << @document.items.build(
          temporary_key: "tkey-#{i}",
          input_language: @document.input_language,
          translated: false,
          output_1_language: @document.output_1_language,
          output_2_language: @document.output_2_language,
          output_3_language: @document.output_3_language,
          output_4_language: @document.output_4_language,
          output_5_language: @document.output_5_language,
        )
      end
    end

    def translate_input_phrase

      @document = TableDocument.find_by_id(params[:document_id])
      new_document unless @document
      @document.input_language ||= params[:input_language]

      @output_1_language = @document.output_1_language ||= params[:output_1_language]
      @output_2_language = @document.output_2_language ||= params[:output_2_language]
      @output_3_language = @document.output_3_language ||= params[:output_3_language]
      @output_4_language = @document.output_4_language ||= params[:output_4_language]
      @output_5_language = @document.output_5_language ||= params[:output_5_language]

      set_languages

      @item = nil
      @item = TableDocumentItem.where(id: params[:item_id]).first unless params[:item_id].starts_with?("tkey")

      if @item.blank?
        @item = @document.items.build(
          temporary_key: params[:item_id],
          input_language: @document.input_language,
          translated: false,
          output_1_language: @document.output_1_language,
          output_2_language: @document.output_2_language,
          output_3_language: @document.output_3_language,
          output_4_language: @document.output_4_language,
          output_5_language: @document.output_5_language,
        )
      end

      word_not_found = {
        "ENGLISH" => "Word not found",
        "ARABIC" => "كلمة غير موجودة",
        "FRENCH" => "Mot introuvable"
      }

      if @item && params[:column_name] && params[:column_name] == 'input_phrase'
        @item.input_phrase = params[:new_value].to_s.strip
        
        unless @item.input_phrase.blank?
 
          if @output_1_language
            hsh = Translation.translate_paragraph(@item.input_phrase, return_in_hash: true, input_language: @input_language, output_language: @output_1_language)
            @item.output_1_phrase = Translation.format_translation(hsh, input_language: @input_language, output_language: @output_1_language, return_string: true) 
            
            unless @output_1_language == @input_language
              save_trans_query(@item.input_phrase, @input_language, @output_1_language, @item.output_1_phrase, params['controller'], hsh)
            end
          end

          if @output_2_language
            hsh = Translation.translate_paragraph(@item.input_phrase, return_in_hash: true, input_language: @input_language, output_language: @output_2_language)
            @item.output_2_phrase = Translation.format_translation(hsh, input_language: @input_language, output_language: @output_2_language, return_string: true) 

            unless @output_2_language == @input_language
              save_trans_query(@item.input_phrase, @input_language, @output_2_language, @item.output_2_phrase, params['controller'], hsh)
            end
          end

          if @output_3_language
            hsh = Translation.translate_paragraph(@item.input_phrase, return_in_hash: true, input_language: @input_language, output_language: @output_3_language) 
            @item.output_3_phrase = Translation.format_translation(hsh, input_language: @input_language, output_language: @output_3_language, return_string: true) 
          
            unless @output_3_language == @input_language
              save_trans_query(@item.input_phrase, @input_language, @output_3_language, @item.output_3_phrase, params['controller'], hsh)
            end
          end

          if @output_4_language
            hsh = Translation.translate_paragraph(@item.input_phrase, return_in_hash: true, input_language: @input_language, output_language: @output_4_language)
            @item.output_4_phrase = Translation.format_translation(hsh, input_language: @input_language, output_language: @output_4_language, return_string: true) 
          end

          if @output_5_language          
            hsh = Translation.translate(@item.input_phrase, return_in_hash: true, input_language: @input_language, output_language: @output_5_language) 
            @item.output_5_phrase = Translation.format_translation(hsh, input_language: @input_language, output_language: @output_5_language, return_string: true) 
          end

          @item.output_1_phrase ||= word_not_found[@item.output_1_language] 
          @item.output_2_phrase ||= word_not_found[@item.output_2_language] 
          @item.output_3_phrase ||= word_not_found[@item.output_3_language] 
          @item.output_4_phrase ||= word_not_found[@item.output_4_language] 
          @item.output_5_phrase ||= word_not_found[@item.output_5_language] 
          @item.translated = true
        else
          @item.input_phrase = params[:new_value]
          
          @item.output_1_phrase = ""
          @item.output_2_phrase = ""
          @item.output_3_phrase = ""
          @item.output_4_phrase = ""
          @item.output_5_phrase = ""
        end
        
        if @document.valid?
          if @item.valid?
            @item.save
          else
            error_message = @item.errors.full_messages.first
            set_notification(false, I18n.t('status.error'), error_message)
          end
        else
          error_message = @item.errors.full_messages.first
          set_notification(false, I18n.t('status.error'), error_message)
        end
      end
    end


    def save_trans_query(input_text, input_language, output_language, output_text, doc_type_param, hsh)

      # Save the translation query for Query/Data Set enhancement
      doc_type = doc_type_param.split('/').last || 'Default'
      error_status = output_text.include? "its-tran-not-found" || false
      
      # Log the translation query to database as a background job
      LogTranslationQueryJob.perform_later(
        input_text || 'Default', 
        input_language || 'Default', 
        output_text || 'Default', 
        output_language || 'Default',
        @current_client_user, 
        doc_type, 
        error_status
      )

       #translation = TranslationQueryHistory.new(
        #input_language: input_language || 'Default', 
        #output_language: output_language || 'Default',
        #input_phrase: input_text || 'Default', 
        #output_phrase: output_text || 'Default',    
        #error: error_status ,                  
        #error_message: hsh || 'Default',            
        #client_user: @current_client_user,      
        #doc_type: doc_type,                                 
        #status: "ACTIVE"
      #)

      #if translation.valid?
        #translation.save
      #end
    end

    def save_everything
      @page_title = "New Document (Table Mode)"
      @nav = 'user/table_documents'

      get_document

      # Redirect to show Page - only if you are on new page
      @redirect_to_show_page = false
      @redirect_to_show_page = true unless @document

      new_document unless @document

      @document.assign_attributes(permitted_params)
      @document.user = @current_client_user

      # Adding Items
      params[:items].each do |key, value|
        next if value[:input_phrase].to_s.strip.blank?
        item = @document.items.find_by_id(value[:item_id]) || @document.items.build()
        item.table_document = @document
        
        item.input_phrase = value[:input_phrase]
        item.output_1_phrase = value[:output_1_phrase]
        item.output_2_phrase = value[:output_2_phrase]
        item.output_3_phrase = value[:output_3_phrase]
        item.output_4_phrase = value[:output_4_phrase]
        item.output_5_phrase = value[:output_5_phrase]
        
        item.input_language = value[:input_language]
        item.output_1_language = value[:output_1_language]
        item.output_2_language = value[:output_2_language]
        item.output_3_language = value[:output_3_language]
        item.output_4_language = value[:output_4_language]
        item.output_5_language = value[:output_5_language]

        if item.input_phrase_changed?
          item.translated = false
        else
          item.translated = value[:translated]
          item.output_1_translation_id = value[:output_1_translation_id]
          item.output_2_translation_id = value[:output_2_translation_id]
          item.output_3_translation_id = value[:output_3_translation_id]
          item.output_4_translation_id = value[:output_4_translation_id]
          item.output_5_translation_id = value[:output_5_translation_id]
        end
      end

      @document.folder = default_folder if params['document'][:folder_id].blank?
       
      if @document.valid?
        @document.save

        save_tags

        set_notification(true, I18n.t('status.success'), I18n.t('success.saved', item: "Document"))
        set_flash_message(I18n.translate("success.saved", item: "Document"), :success)
      else
        message = I18n.t('errors.failed_to_save', item: "Document")
        @document.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end

    def csv_upload

      new_document
      set_languages

    end

    def csv_parse
      csv_file = params[:file]
      @errors = nil
      @csv_content = nil
      if csv_file
        begin
          @csv_content = CSV.read(csv_file.path)
        rescue
          @errors = "Unable to read the contents of the uploaded file"
        end
      else
        @errors = "CSV file not uploaded"
      end

      # Parse the CSV and create new table mode document
      if @errors.blank? && @csv_content

        new_document
        set_languages

        @document.user = @current_client_user

        # filename = csv_file.original_filename.gsub(".csv", "").titleize
        # @document.title = "#{filename} - #{Time.now.to_i}"
        @document.title = csv_file.original_filename
        @document.input_language = params[:input_language]
        
        # Adding Items
        @csv_content.each do |row|
          val = row.first.to_s.strip
          next if row.empty?
          next if val.blank?

          item = @document.items.build(
            table_document: @document,
            input_phrase: val,
            input_language: @document.input_language,
            output_1_language: @document.output_1_language,
            output_2_language: @document.output_2_language,
            output_3_language: @document.output_3_language,
            output_4_language: @document.output_4_language,
            output_5_language: @document.output_5_language,
            translated: false
          )
        end

        if @document.valid?

          @document.save

          set_notification(true, I18n.t('status.success'), I18n.t('success.saved', item: "Document"))
          set_flash_message(I18n.translate("success.saved", item: "Document"), :success)
        else
          message = I18n.t('errors.failed_to_save', item: "Document")
          @document.errors.add :base, message
          set_notification(false, I18n.t('status.error'), message)
          set_flash_message('The form has some errors. Please correct them and submit again', :error)
        end
      end
      
    end

    def export_to_excel
      get_document
      @document_items = @document.items

      respond_to do |format|
        format.xlsx {
          response.headers['Content-Disposition'] = "attachment; filename=its-#{@document.to_param}.xlsx"
        }
      end
    end

    def clear
      get_document
      new_document unless @document
      if @document.persisted?
        @document.items.destroy_all 
        redirect_to user_table_document_path(@document)
      else
        redirect_to new_user_table_document_path(input_language: params[:input_language], title: params[:title])
      end
    end

    # TODO: Need to remove this function. After detail testing remove this methord
    # It will implemented on Document controller to update the status of document
    def update_status
      get_document
      if @document
        @document.update_status(params[:status].upcase)
      end
    end
   
      # Update the document while drag and drop the document to folder(change the folder id of the document)
     def update_folder
      get_document
      
      if@document
        @document.update_column(:folder_id,params[:folder_id])

        set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "Folder"))
        set_flash_message(I18n.translate("success.saved", item: "Folder"), :success)
      end
    end
    
    private
    
    def check_default_document_folder
      @document_folder=DocumentFolder.where(user_id: current_client_user.id,title:'Default').first
       
      if @document_folder.blank?
        @document_folder=DocumentFolder.new
        @document_folder.title='Default'
        @document_folder.user_id=@current_client_user.id
        @document_folder.save
      end
    end
    
    def get_collection
      @order_by = "created_at DESC" unless @order_by
      @relation = TableDocument.where("")

      apply_filters
      @per_page = 100
      @documents = @relation.order(@order_by).page(@current_page).per(@per_page)
    end

    def apply_filters
      @query = params[:q]
      @relation = @relation.search(@query) if @query && !@query.blank?
      @relation = @relation.status(params[:status].upcase)   if params[:status] 

      @relation = @relation.search_only_title(params[:filters].try(:[], :title))
      @relation = @relation.search_only_input_language(params[:filters].try(:[], :input_language))
      # @relation = @relation.search_only_output_language(params[:filters].try(:[], :output_language))
      @relation = @relation.search_only_status(params[:filters].try(:[], :status))
    end

    def get_document
      @document = TableDocument.find_by_id(params[:id])
      set_languages
    end

    def new_document
      @document = TableDocument.new()
      @document.assign_attributes(permitted_params) if params[:document]
      @document.input_language = params[:input_language]
      @document.output_1_language = params[:output_1_language]
      @document.output_2_language = params[:output_2_language]
      @document.output_3_language = params[:output_3_language]
      
      # Set Default Title
      @document.title ||= params[:title] if params[:title]
      @document.title ||= "New Table Document - #{Time.now.to_i}"

      # Set Default Folder
      @document.folder = default_folder

      # Set Defaut Languages
      set_languages

      @document
    end

    def default_folder
      @current_client_user.default_folder || @current_client_user.create_default_folder
    end

    def set_languages
      if @document
        @input_language = @document.input_language ||= "ENGLISH"
        @output_1_language = @document.output_1_language ||= "ENGLISH"
        @output_2_language = @document.output_2_language ||= "FRENCH"
        @output_3_language = @document.output_3_language ||= "ARABIC"
        # @output_4_language = @document.output_4_language ||= "GERMAN"
        # @output_5_language = @document.output_5_language ||= "CHINESE"
      end
    end

    def save_tags
      params[:tags].split(',').each do |tag_name|
          @document.tags.first_or_create(name: tag_name.strip)
        end if params[:tags] and params[:tags].any?
    end

    def permitted_params
      params.require("document").permit(
        :title,
        :input_language,
        :output_1_language,
        :output_2_language,
        :output_3_language,
        :output_4_language,
        :output_5_language,
        :folder_id
      )
    end

  end
end
