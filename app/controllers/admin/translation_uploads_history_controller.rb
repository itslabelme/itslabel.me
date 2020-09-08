module Admin
  class TranslationUploadsHistoryController < Admin::BaseController
  	
  	def index
      @page_title = "Translations History"
      @nav = 'admin/translation_uploads_history'

      get_history
  	end

  	def create
  		
  	end

  	def show
      @summary=UploadsSummary.find(params[:id])
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
  end
end