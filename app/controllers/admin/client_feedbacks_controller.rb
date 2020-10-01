module Admin
  class ClientFeedbacksController < Admin::BaseController
    
    include TableSettings::ClientFeedbacksTs

    before_action :authenticate_admin_user!
    before_action :get_user, except: [:new, :create, :index]
    before_action :configure_client_feedbacks_table_settings
    
    def index
      @page_title = "Admin Feedbacks | Admin"
      @nav = 'admin/client_feedbacks'
      get_collection
    end
   
    private  
      def get_collection
        @order_by = "created_at DESC" unless @order_by
        @relation = ClientFeedback.all
        @per_page = 10
        @client_feedback = @relation.order(@order_by).page(@current_page).per(@per_page)
      end
  end
end
