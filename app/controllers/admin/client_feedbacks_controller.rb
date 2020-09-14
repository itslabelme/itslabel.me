module Admin
  class ClientFeedbacksController < Admin::BaseController
    
    before_action :authenticate_admin_user!
    before_action :get_user, except: [:new, :create, :index]
    
    def index

      @page_title = "Admin Users | Admin"
      @nav = 'admin/client_feedbacks'

      @feedback=ClientsFeedback.all

    end
  end
end
