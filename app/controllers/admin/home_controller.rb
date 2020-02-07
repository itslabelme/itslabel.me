module Admin
  class HomeController < Admin::BaseController

    before_action :authenticate_admin_user!

    def index

      @page_title = "Home | Admin"
      @nav = "admin/home"
      total_user
      get_total_users
      get_total_documents
      get_total_tags
      get_new_users
      get_return_users
    end
    
    private
    def total_user
      @total_clients=ClientUser.all.count
    end
    
    def get_total_users
      @client_users=ClientUser.all
    end
    
    def get_total_documents
      @total_documents=Document::Base.all.count
    end
    
    def get_total_tags
      @total_tags=Tag.all.count
    end
    
    def get_new_users
     @total_new_users= ClientUser.where('created_at >= ?', 1.week.ago).count
    end
    
    def get_return_users
     @total_return_users= ClientUser.where('sign_in_count > ?', 1).count
    end
  end
end