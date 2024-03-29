module User
  class TemplateDocumentsController < User::BaseController

    before_action :authenticate_client_user!
    before_action :get_document, except: [:new, :create, :index, :select_template]
    before_action :access_denied, only: [:index, :new, :select_template]

    
    def index
      @page_title = "Documents (Template Mode)"
      @nav = 'user/template_documents'

      get_collection
    end

    def show
      get_document
      
      @nav = 'user/template_documents'
      @page_title = @document.title

      # Redirect to show Page - only if you are on new page
      @redirect_to_show_page = false
    end

    def preview
      get_template
      new_document unless @document
      render layout: 'iframe_preview'
    end

    def select_template
      @page_title = "Choose a Template"
      @nav = 'user/template_documents'
    end

    def export_template_documents_translation
      get_template
      new_document unless @document
      
      respond_to do |format|
        format.html
        format.pdf do
          render  pdf: 'file_name',
                  template: '/user/template_documents/export_template_documents_translation.pdf.erb',
                  layout: 'pdf.html.erb',
                  formats: :HTML, 
                  encoding: 'utf8'
                  #:show_as_html => params[:debug].present?
        end
      end

      # if @preview
      #   # For Preview functionality
      #   pdf = WickedPdf.new.pdf_from_string(
      #           render  pdf: 'file_name',
      #                   template: '/user/template_documents/export_template_documents_translation.pdf.erb',
      #                   layout: 'pdf.html.erb',
      #                   formats: :HTML, 
      #                   encoding: 'utf8'
      #         )
      # else
      #   # For Preview functionality
      #   pdf = WickedPdf.new.pdf_from_string(
      #           render_to_string('/user/template_documents/export_template_documents_translation.pdf.erb', layout: false, formats: :HTML, encoding: 'utf8')
      #         )
      #   send_data pdf, :filename => "Template Document_#{Date.today.strftime('%d/%b/%Y')}.pdf", :type => "application/pdf", :disposition => "attachment"
      # end
    end

    def export_template_documents_translation_backup
      get_template
      new_document unless @document
      @preview=params[:value]

      if @preview
        # For Preview functionality
        pdf = WickedPdf.new.pdf_from_string(
                render  pdf: 'file_name',
                        template: '/user/template_documents/export_template_documents_translation.pdf.erb',
                        layout: 'pdf.html.erb',
                        formats: :HTML, 
                        encoding: 'utf8'
              )
      else
        # For Preview functionality
        pdf = WickedPdf.new.pdf_from_string(
                render_to_string('/user/template_documents/export_template_documents_translation.pdf.erb', layout: false, formats: :HTML, encoding: 'utf8')
              )
        send_data pdf, :filename => "Template Document_#{Date.today.strftime('%d/%b/%Y')}.pdf", :type => "application/pdf", :disposition => "attachment"
      end
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
      @document.folder = default_folder if params['document'][:folder_id].blank?
      @document.user = @current_client_user

      set_languages

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

    def print
      get_template
      new_document unless @document
      render layout: 'iframe_preview'
    end

    def update_status
      get_document
      @document.update_status(params[:status].upcase) if @document
    end

    def update_folder
      get_document
      if@document
        @document.update_column(:folder_id,params[:folder_id])
        set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "Folder"))
        set_flash_message(I18n.translate("success.saved", item: "Folder"), :success)
      end
    end

    private

    def get_collection
      @order_by = "created_at DESC" unless @order_by
      @relation = TemplateDocument.where("")

      apply_filters
      @per_page = 100
      @documents = @relation.order(@order_by).page(@current_page).per(@per_page)
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
      @template ||= @document.template
      
      # Get all Document Folders
      @document_folders = @current_client_user.document_folders
      set_languages
    end
    
    def new_document
      @document = TemplateDocument.new(input_language: "ENGLISH", output_language: "ARABIC")
      
      # Set Default Title
      @document.title = "New Template Document - #{Time.now.to_i}" unless @document.title

      # Set Default Folder
      @document.template = @template

      # Set Default Folder
      @document.folder = default_folder

      # Get all Document Folders
      @document_folders = @current_client_user.document_folders

      # Set Template
      if @template
        logo_url = ActionController::Base.helpers.asset_path("distributor-logo.jpg")
        @document.template = @template
        if @document.try(:input_language).to_s.upcase == "ARABIC" 
          formatted_source_html = @template.rtl_html_source.gsub("{LOGO_URL}", logo_url)
        else
          formatted_source_html = @template.ltr_html_source.gsub("{LOGO_URL}", logo_url)
        end
      end
      @document.input_html_source = formatted_source_html

      @document.translate

      # Set Defaut Languages
      set_languages

      @document
    end

    def default_folder
      @current_client_user.document_folders.where(title: "Default").first || @current_client_user.create_default_folder
    end

    def set_languages
      if @document
        @input_language = @document.input_language ||= "ENGLISH"
        @output_language = @document.output_language ||= "ARABIC"
      end
    end

    def get_template
      if params[:template_id]
        @template = LabelTemplate.find_by_id(params[:template_id]) 
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
        :folder_id
      )
    end

  end
end
