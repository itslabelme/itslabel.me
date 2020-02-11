module User
  class DocumentsController < User::BaseController

    before_action :authenticate_client_user!
    
    def index
      @page_title = "Your Documents"
      @nav = 'user/documents'

      get_collection
    end

    private

    def get_collection
      @order_by = "created_at DESC" unless @order_by
      @relation = TemplateDocument.where("")

      apply_filters

      @documents = @relation.order(@order_by).page(@current_page).per(@per_page)
    end

    def apply_filters
      @query = params[:q]
      @relation = @relation.search(@query) if @query && !@query.blank?

      # Filter by Status
      @relation = @relation.status(params[:status].upcase) if params[:status]

      # Filter by Favorite
      @relation = @relation.only_favorites if params[:favorite]
      @relation = @relation.search_only_title(params[:filters].try(:[], :title))
      @relation = @relation.search_only_input_language(params[:filters].try(:[], :input_language))
      @relation = @relation.search_only_status(params[:filters].try(:[], :status))
    end

  end
end
