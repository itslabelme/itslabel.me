module User
  class TemplateDocumentsController < User::BaseController

    before_action :authenticate_client_user!
    before_action :get_document, except: [:new, :create, :index, :select_template]

    def index
      @page_title = "Template Documents"
      @nav = 'user/template_documents'

      get_collection
      new_document
    end

    def show
      get_document
      
      @nav = 'user/template_documents'
      @page_title = @document.title

      # Redirect to show Page - only if you are on new page
      @redirect_to_show_page = false
    end

    def select_template
      @page_title = "Choose a Template"
      @nav = 'user/template_documents'
    end

    def new
      @page_title = "Create new Translation Document from Template"
      @nav = 'user/template_documents'

      get_template
      new_document
    end

    def save_and_translate
      @page_title = "Create new Translation Document from Template"
      @nav = 'user/template_documents'

      get_document if params[:id]

      # Redirect to show Page - only if you are on new page
      @redirect_to_show_page = false
      @redirect_to_show_page = true unless @document

      get_template
      new_document unless @document

      @document.assign_attributes(permitted_params)
      @document.user = @current_client_user

      if @document.valid?
        @document.save

        params[:tags].split(',').each do |tag_name|
          @document.tags.first_or_create(name: tag_name.strip)
        end if params[:tags] and params[:tags].any?

        set_notification(true, I18n.t('status.success'), I18n.t('success.saved', item: "Document"))
        set_flash_message(I18n.translate("success.saved", item: "Document"), :success)
      else
        message = I18n.t('errors.failed_to_save', item: "Document")
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


    def update_status
      if @document
        @document.update_status(params[:status].upcase)
      end
    end


    def print
      get_document

      respond_to do |format|
        format.html do
          render layout: nil
        end
      end
    end


    private

    def get_collection
      @order_by = "created_at DESC" unless @order_by
      @relation = TemplateDocument.where("")

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
      @document = TemplateDocument.find_by_id(params[:id])
      set_languages
    end

    def new_document
      @document = TemplateDocument.new(input_language: "ENGLISH", output_language: "ARABIC", output_language: "ARABIC")
      
      # Set Default Title
      @document.title = "New Document - #{Time.now.to_i}" unless @document.title

      # Set Template
      if @template
        @document.template = @template
        @document.input_html_source = @template.ltr_html_source
      end

      # Set Defaut Languages
      set_languages

      @document
    end

    def set_languages
      if @document
        @input_language = @document.input_language ||= "ENGLISH"
        @output_language = @document.output_language ||= "ARABIC"
      end
    end

    def get_template
      if params[:template_id]
        @template = LabelTemplate.find(params[:template_id]) 
      elsif @document
        @template = @document.template
      end
    end

    def permitted_params
      params.require("document").permit(
        :title,
        :input_language,
        :output_language,
        :input_html_source,
      )
    end

  end
end