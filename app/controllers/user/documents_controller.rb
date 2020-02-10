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

    def select_template
      @page_title = "Choose a Template"
      @nav = 'user/documents'
    end

    def new
      @page_title = "Create new Translation Document from Template"
      @nav = 'user/documents'
      new_document
      get_template

      @document.title = "New Document - #{Time.now.to_i}" unless @document.title

      if @template
        @document.template = @template
        @document.input_html_source = @template.ltr_html_source
      end
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
        @document.user = @current_client_user
        @document.save

        params[:tags].split(',').each do |tag_name|
          @document.tags.first_or_create(name: tag_name.strip)
        end if params[:tags] and params[:tags].any?

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

    def apply_filters
      @query = params[:q]
      @relation = @relation.search(@query) if @query && !@query.blank?
      
      @relation = @relation.search_only_title(params[:filters].try(:[], :title))
      @relation = @relation.search_only_input_language(params[:filters].try(:[], :input_language))
      # @relation = @relation.search_only_output_language(params[:filters].try(:[], :output_language))
      @relation = @relation.search_only_status(params[:filters].try(:[], :status))
      
    end

    def get_collection
      @order_by = "created_at DESC" unless @order_by
      @relation = @document_class

      apply_filters

      @documents = @relation.order(@order_by).
                      page(@current_page).per(@per_page)
    end

    def get_document_class
      @document_class if @document_class
      if params[:dt] == 'table'
        @document_class = Document::TableBased
      else
        @document_class = Document::TemplateBased
      end
      @document_class
    end

    def get_document
      @document_class = get_document_class
      @document = @document_class.find_by_id(params[:id])
      @document_class = @document.type.constantize

      @input_language = @document.input_language ||= "ENGLISH"
      @output_language = @document.output_1_language ||= "ARABIC"
    end

    def new_document
      @document = @document_class.new(input_language: "ENGLISH", output_1_language: "ARABIC", output_2_language: "ARABIC")
      # @document = @document_class.new([{input_language: "ENGLISH", output_1_language: "ARABIC"},{input_language: "ENGLISH", output_1_language: "ARABIC"}, {input_language: "ENGLISH", output_1_language: "ARABIC"}])
    end

    def get_template
      @template = LabelTemplate.find(params[:template_id]) if params[:template_id]
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
        :input_html_source,
      )
    end

  end
end
