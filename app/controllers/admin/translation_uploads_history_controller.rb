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
      @history=TranslationUploadsHistory.all
  	end
  end
end