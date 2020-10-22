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
      @doc_type=params[:filters].try(:[], :ob)
      start_date=params[:filters].try(:[], :sd) 
      end_date=params[:filters].try(:[], :ed)
      @query = params[:q]
      @relation = @relation.search(@query) if @query && !@query.blank?
      
      @relation = @relation.search_only_input_phrase(params[:filters].try(:[], :input_phrase))
      @relation = @relation.search_only_output_phrase(params[:filters].try(:[], :output_phrase))
      @relation = @relation.search_only_input_language(params[:filters].try(:[], :input_language))
      @relation = @relation.search_only_output_language(params[:filters].try(:[], :output_language))
      @relation = @relation.search_only_status(params[:filters].try(:[], :status))
      @relation = @relation.search_only_error(params[:filters].try(:[], :error))

      @relation = @relation.where(doc_type: @doc_type) if @doc_type

      if start_date.blank? && end_date.blank?
        @sd=(Date.today-1).strftime('%Y-%m-%d %H:%M')
        @ed=Time.now.in_time_zone("Asia/Muscat").strftime('%Y-%m-%d %H:%M')
        @relation = @relation.where(created_at: @sd..@ed) 
      else
        @sd=start_date.in_time_zone("Asia/Muscat").strftime('%Y-%m-%d %H:%M')
        @ed=end_date.in_time_zone("Asia/Muscat").strftime('%Y-%m-%d %H:%M')
        @relation = @relation.where(created_at: @sd..@ed)
      end  

    end
    
    def get_collection
       
      @order_by = "created_at DESC" unless @order_by

      @relation = TranslationQueryHistory.where("")

      apply_filters
      
      @translationQueryHistories = @relation.
                        order(@order_by).
                        page(@current_page).per(100)
    end

    def get_translation
      @translationQueryHistory = TranslationQueryHistory.find_by_id(params[:id])
    end



  end
end
