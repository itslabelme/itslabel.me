module User
  class TableDocumentsController < User::BaseController

    before_action :authenticate_client_user!
    before_action :get_document, except: [:new, :create, :index, :select_template]
    skip_before_action :verify_authenticity_token, :only => [:translate_input_phrase, :save_everything]
    
    def index
      @page_title = "Documents (Table Mode)"
      @nav = 'user/table_documents'

      get_collection
    end

    def show
      get_document
      
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

      new_document

      @document_items = []
      16.times.each do |i|
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

      if params[:item_id].starts_with?("tkey")
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
      else
        @item = TableDocumentItem.where(id: params[:item_id]).first
      end

      word_not_found = {
        "ENGLISH" => "Word not found",
        "ARABIC" => "كلمة غير موجودة",
        "FRENCH" => "Mot introuvable"
      }

      if @item && params[:column_name] && params[:column_name] == 'input_phrase'
        @item.input_phrase = params[:new_value].to_s.strip
        
        unless @item.input_phrase.blank?
          @item.output_1_phrase = Translation.translate_word(@item.input_phrase, input_language: @input_language, output_language: @output_1_language) if @output_1_language
          @item.output_2_phrase = Translation.translate_word(@item.input_phrase, input_language: @input_language, output_language: @output_2_language) if @output_2_language
          @item.output_3_phrase = Translation.translate_word(@item.input_phrase, input_language: @input_language, output_language: @output_3_language) if @output_3_language
          @item.output_4_phrase = Translation.translate_word(@item.input_phrase, input_language: @input_language, output_language: @output_4_language) if @output_4_language
          @item.output_5_phrase = Translation.translate_word(@item.input_phrase, input_language: @input_language, output_language: @output_5_language) if @output_5_language

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
            set_notification(false, I18n.t('status.error'), @item.errors.full_messages.join("<br>"))
          end
        end
      end
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

    def export_to_excel
      get_document
      @document_items = @document.items

      respond_to do |format|
        format.xlsx {
          response.headers['Content-Disposition'] = "attachment; filename=its-#{@document.to_param}.xlsx"
        }
      end
    end

    def update_status
      get_document
      if @document
        @document.update_status(params[:status].upcase)
      end
    end
    
    private

    def get_collection
      @order_by = "created_at DESC" unless @order_by
      @relation = TableDocument.where("")

      apply_filters

      @documents = @relation.order(@order_by).
                      page(@current_page).per(@per_page)
    end

    def apply_filters
      @query = params[:q]
      @relation = @relation.search(@query) if @query && !@query.blank?

      if params[:status] 
        @relation = @relation.status(params[:status].upcase)  
      end

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
      @document.title ||= "New Table Document - #{Time.now.to_i}" unless @document.title

      # Set Defaut Languages
      set_languages

      @document
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
        :output_5_language
      )
    end

  end
end
