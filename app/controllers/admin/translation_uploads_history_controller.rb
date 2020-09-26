module Admin
  class TranslationUploadsHistoryController < Admin::BaseController
  	
  	def index
      @page_title = "Database Upload History"
      @nav = 'admin/translations'

      # get_history
      get_collection
  	end

  	def create
  		
  	end

  	def show
      @page_title = "Database Upload History"
      @nav = 'admin/translations'
      # @summary=UploadsSummary.find(params[:id])

      # Edited by sanoop 
      # get_summary
      @summary=UploadsSummary.find_by_translation_uploads_history_id(params[:id])
      @history=UploadsHistory.find(params[:id])
  	end

  	def create
  		
  	end

  	def edit
  		
  	end
  	def update
  		
  	end

  	def destroy
  		
  	end
  	def get_history
      @history=UploadsHistory.all
  	end

    private

    def get_collection
      @order_by = "created_at DESC" unless @order_by

      @relation = UploadsHistory.where("")

      @history = @relation.order(@order_by).page(@current_page).per(@per_page)
    end

    def get_summary
      @relation = UploadsSummary.where(translation_uploads_history_id: params[:id])

      @summary = @relation.page(@current_page).per(100)
    end
  end
end