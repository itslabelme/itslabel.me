module User
  class DocumentsController < User::BaseController

    before_action :authenticate_client_user!
    before_action :access_denied
    def index
      @page_title = "Your Documents"
      @nav = 'user/documents'

      get_collection
    end

    def update_status
      if @document
        @document.update_status(params[:status].upcase)
      end
    end

    def destroy
      get_document

      if @document
        if @document.can_be_deleted?
          @document.destroy
          
          set_notification(false, I18n.t('status.success', item: "Document"), I18n.t('success.deleted', item: "Document"))
          set_flash_message(I18n.t('success.deleted', item: "Document"), :success, false)
          @destroyed = true
        else
          message = I18n.t('errors.cannot_be_deleted', item: "Document", reason: @document.errors.full_messages.join("<br>"))
          set_flash_message(message, :failure)
          set_notification(false, I18n.t('status.error'), message)
          @destroyed = false
        end
      end
    end

    private

    def get_collection
      @relation = DocumentView.where(user_id: @current_client_user.id)

      apply_filters
      if params[:status].to_s.strip.blank? && @status.to_s.downcase != "all"
        @relation = @relation.all_statuses_expect(["ARCHIVED", "REMOVED"])
      else
        @relation = @relation.status(params[:status].to_s.strip.upcase) unless params[:status].to_s.strip.blank?
      end

      @documents = @relation.order(@order_by).page(@current_page).per(@per_page)
    end

    def get_document
      @document = Document::Base.find_by_id(params[:id])
      @document_class = @document.type.constantize
    end

    def apply_filters
      @query = params[:q]
      @relation = @relation.search(@query) if @query && !@query.blank?

      # Filter by Status
      @relation = @relation.status(params[:status].to_s.strip.upcase) unless params[:status].to_s.strip.blank?

      # Filter by Favorite
      @relation = @relation.only_favorites if params[:favorite]

      @relation = @relation.search_only_title(params[:filters].try(:[], :title))
      @relation = @relation.search_only_input_language(params[:filters].try(:[], :input_language))
      @relation = @relation.search_only_status(params[:filters].try(:[], :status))

      
      f_title = params[:f_title]
      @relation = @relation.search_only_title(f_title) if f_title

      f_input_language = params[:f_ilang]
      @relation = @relation.search_only_input_language(f_input_language) if f_input_language

      f_output_language = params[:f_olang]
      @relation = @relation.search_only_output_language(f_output_language) if f_output_language

      # Recent
      @relation = @relation.recent

      # Set Default Order
      @order_by = "created_at DESC" unless @order_by
      

    end

  end
end
