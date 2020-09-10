module Admin
  class TranslationQueryHistoriesController < Admin::BaseController

    before_action :authenticate_admin_user!
    before_action :get_translation, except: [:new, :create, :index]

    def index
      @page_title = "Translations Query History"
      @nav = 'admin/reports'

      get_collection
      # new_translation
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
      @relation = @relation.search_only_error(params[:filters].try(:[], :error))
      
    end
    
    def get_collection
       
      @order_by = "created_at DESC" unless @order_by

      @relation = TranslationQueryHistory.where("")

      apply_filters
      
      @translationQueryHistories = @relation.
                        order(@order_by).
                        page(@current_page).per(@per_page)
    end
    
  
    def get_translation
      @translationQueryHistory = TranslationQueryHistory.find_by_id(params[:id])
    end



  end
end
