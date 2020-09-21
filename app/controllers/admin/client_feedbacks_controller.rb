module Admin
  class ClientFeedbacksController < Admin::BaseController
    
    before_action :authenticate_admin_user!
    before_action :get_user, except: [:new, :create, :index]
    
    def index

      @page_title = "Admin Feedbacks | Admin"
      @nav = 'admin/client_feedbacks'

      @client_feedback=ClientFeedback.all
      
    end
  end
end
