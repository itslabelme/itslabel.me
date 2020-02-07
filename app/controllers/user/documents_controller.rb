module User
  class DocumentsController < User::BaseController

    before_action :authenticate_client_user!
    before_action :get_document, except: [:new, :create, :index, :select_template]
    before_action :get_document_class

    def index
      @page_title = "Documents Database"
      @nav = 'user/documents'

      get_document_class
      get_collection
      new_document
    end

    def show
      @page_title = "Document"
      @nav = 'user/documents'
      get_document
    end

    def translate
      get_document
      @document.input_html_source = params[:input_html_source]
      @document.save
    end

    def select_template
      @page_title = "Choose a Template"
      @nav = 'user/documents'
    end

    def new
      @page_title = "Create new Translation Document from Template"
      @nav = 'user/documents'
      new_document
    end

    def edit
      @page_title = "Edit Document"
      @nav = 'user/documents'
      get_document
    end

    def create
      get_document_class
      new_document
      @document.assign_attributes(permitted_params)
      @document.input_html_source = @document.template.ltr_html_source if @document.template
      @document.user = @current_client_user
      @document.description = @document.title

      if @document.valid?
        # binding.pry
        begin
          @document.save

          params[:tags].split(',').each do |tag_name|
            @document.tags.create(name: tag_name.strip)
          end
        rescue
        end
        set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "Document"))
        set_flash_message(I18n.translate("success.created", item: "Document"), :success)
      else
        message = I18n.t('errors.failed_to_create', item: "Document")
        @document.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end

    def update
      get_document
      @document.assign_attributes(permitted_params)
      
      if @document.valid?
        @document.user = @current_page
        @document.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "Document"))
        set_flash_message(I18n.translate("success.updated", item: "Document"), :success)
      else
        message = I18n.t('errors.failed_to_update', item: "Document")
        @document.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end

    def destroy
      get_document

      if @document
        if @document.can_be_deleted?
          @document.destroy
          
          set_notification(false, I18n.t('status.success', item: "Document"), I18n.t('success.deleted', item: "Document"))
          set_flash_message(I18n.t('success.deleted', item: "Document"), :success, false)
          @destroyed = true
        else
          message = I18n.t('errors.cannot_be_deleted', item: "Document", reason: @document.errors.full_messages.join("<br>"))
          set_flash_message(message, :failure)
          set_notification(false, I18n.t('status.error'), message)
          @destroyed = false
        end
      end
    end

    private

    def get_collection
      @order_by = "created_at DESC" unless @order_by
      @documents = @document_class.
                      order(@order_by).
                      page(@current_page).per(@per_page)
    end

    def get_document_class
      if params[:dt] == 'template'
        @document_class = Document::TemplateBased
      else
        @document_class = Document::TableBased
      end
    end

    def get_document
      @document = Document::Base.find_by_id(params[:id])
      @document_class = @document.type.constantize
    end

    def new_document
      @document = @document_class.new(input_language: "ENGLISH", output_1_language: "ARABIC")
    end

    def permitted_params
      params.require("document_template_based").permit(
        :title,
        :description,
        :input_language,
        :output_1_language,
        :output_2_language,
        :output_3_language,
        :output_4_language,
        :output_5_language,
        :template_id,
      )
    end

  end
end
