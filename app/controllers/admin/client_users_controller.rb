module Admin
  class ClientUsersController < Admin::BaseController

    before_action :authenticate_admin_user!
    before_action :get_client_user, except: [:new, :create, :index]
    
    def index
      @page_title = "Client Users"
      @nav = "admin/registrations"
      @current_page=params[:page]
     # get_collection 
      if (params.has_key? (:q))
        get_search
      else if(params.has_key?( params[:country]) || (params[:name]) || (params[:mobile_number]))
        get_advancesearch
      
      else
        get_collection  
      end
      end
    end
    
    def show
    end
  
    private 
    def get_search
      
      key = "%#{params[:q]}%"
      @client_users = ClientUser.where('first_name LIKE :search OR last_name LIKE :search OR email LIKE :search', search: key).page(@current_page).per(@per_page)
      
    end
    
    def get_advancesearch
      condition = " 1=1 "
        if(params[:country].blank? and params[:name].blank? and params[:mobile_number].blank? )
            @order_by = "created_at DESC" unless @order_by
            @client_users = ClientUser.
            order(@order_by).
            page(@current_page).per(@per_page)
        else
            if params[:country].present?
            condition += " AND country='#{params[:country]}'" if params.key?(:country)
            end
            if params[:mobile_number].present?
            condition += " AND mobile_number='#{params[:mobile_number]}'" if params.key?(:mobile_number)
            end
            if params[:name].present?
            condition += " AND (first_name LIKE '%#{params[:name]}%' OR last_name LIKE '%#{params[:name]}%' OR email LIKE '%#{params[:name]}%' ) " if params.key?(:name)
            end 
            @client_users =ClientUser.where("#{condition}").page(@current_page).per(@per_page)
        end
    end
    
    def get_client_user
      @client_user = ClientUser.find_by_id(params[:id])
    end
  
    def get_collection
      @order_by = "created_at DESC" unless @order_by
      @client_users = ClientUser.
        order(@order_by).
        page(@current_page).per(@per_page)
    end
    
  end
end
