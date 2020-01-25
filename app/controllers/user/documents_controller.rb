module User
  class DocumentsController < User::BaseController

    before_action :authenticate_client_user!
    before_action :get_document, except: [:new, :create, :index]
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
      # binding.pry
    end

    def new
      @page_title = "Add a Document"
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
      @document.assign_attributes(permitted_doument_template_based_params)
      @document.user = @current_client_user
      
      if @document.valid?
        @document.save
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
      @document.assign_attributes(permitted_doument_template_based_params)
      
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
      @document = @document_class.new
    end

    def permitted_doument_params
      params.require("document").permit(
        :input_language,
        :input_phrase,
        :input_description,
        :output_phrase,
        :output_description,
        :output_language,
      )      
    end

    def permitted_doument_template_based_params
      params.require("document_template_based").permit(
        :title,
        :description,
        :input_language,
        :output_1_language,
        :output_2_language,
        :output_3_language,
        :output_4_language,
        :output_5_language,
      )
    end

  end
end
