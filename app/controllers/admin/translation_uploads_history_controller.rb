module Admin
  class TranslationUploadsHistoryController < Admin::BaseController
  	
  	def index
      @page_title = "Database Upload History"
      @nav = 'admin/translations'

      get_collection
  	end

  	def show
      @page_title = "Database Upload History"
      @nav = 'admin/translations'
      
      @upload_history = UploadsHistory.find(params[:id])
      # FIX ME - this method needs to be removed. instead use associatoin. 
      # @upload_summary = @upload_history.summary
      if params[:lan].nil?
        @input_language = "en"
      else
        @input_language = params[:lan]
      end
      @upload_summary = UploadsSummary.find_by_translation_uploads_history_id(params[:id])
  	end

  	private

    def get_collection
      @order_by = "created_at DESC" unless @order_by
      @relation = UploadsHistory.where("")
      @upload_histories = @relation.order(@order_by).page(@current_page).per(@per_page)
    end
    
  end
end