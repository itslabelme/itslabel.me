module Admin
  class TranslationRequestsController < Admin::BaseController

    include TableSettings::TranslationRequestsTs

    before_action :authenticate_admin_user!, only: [:new, :create, :index, :show]
    before_action :configure_translation_requests_table_settings

    def index
      @page_title = "Translations Requests"
      @nav = 'admin/translations'

      get_collection
    end

    def show
      @page_title = "Translations Requests"
      @nav = 'admin/translations'
      get_translation_requests
    end
    
    def new
      @page_title = "Add a Translation"
      @nav = 'admin/translations'
      new_translation_requests
    end

    def create
      new_translation_requests
      @translation_requests.assign_attributes(permitted_params)
      
      if @translation_requests.valid?
        @translation_requests.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "Translation"))
        set_flash_message(I18n.translate("success.created", item: "Translation"), :success)
      else
        message = I18n.t('errors.failed_to_create', item: "Translation")
        @translation_requests.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end

   private

    def apply_filters
      @query = params[:q]

      @relation = @relation.search(@query) if @query && !@query.blank?
      
      @relation = @relation.search_only_input_phrase(params[:filters].try(:[], :input_phrase))
      @relation = @relation.search_only_output_phrase(params[:filters].try(:[], :output_phrase))
      @relation = @relation.search_only_input_language(params[:filters].try(:[], :input_language))
      @relation = @relation.search_only_output_language(params[:filters].try(:[], :output_language))
      @relation = @relation.search_only_status(params[:filters].try(:[], :status))
      
    end
    
    def get_collection
       
      @order_by = "created_at DESC" unless @order_by

      @relation = TranslationRequest.where("")

      apply_filters
      
      @translation_requests = @relation.
                        order(@order_by).
                        page(@current_page).per(5)
    end
    
  

    def get_translation_requests
      @translation_requests = TranslationRequest.find_by_id(params[:id])
    end

    def new_translation_requests
      @translation_requests = TranslationRequest.new
    end
    
    def permitted_params
      params.require("translation_requests").permit(
         :requested_by,
         :input_phrase,
         :input_language,
         :output_phrase,
         :output_language,
         :doc_type,
         :status
      )
    end
    
  end
end
