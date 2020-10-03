module Admin
  class TranslationRequestsController < Admin::BaseController

    include TableSettings::TranslationRequestsTs

    before_action :authenticate_admin_user!, only: [:index, :show]
    before_action :configure_translation_requests_table_settings

    def index
      @page_title = "Translations Requests"
      @nav = 'admin/reports'

      get_collection
    end

    def show
      @page_title = "Translations Requests"
      @nav = 'admin/reports'
      get_translation_requests
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
      @per_page = 40
      @translation_requests = @relation.
                        order(@order_by).
                        page(@current_page).per(@per_page)
    end
    
  

    def get_translation_requests
      @translation_requests = TranslationRequest.find_by_id(params[:id])
    end
 
  end
end
