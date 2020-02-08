module Admin
  class ClientUsersController < Admin::BaseController

    before_action :authenticate_admin_user!
   
    before_action :get_client_user, except:[:index]
    def index
      @page_title = "Client Users"
      @nav = "admin/registrations"
    
      get_collection 
      new_client_user
    end
    
    
    def show
       get_client_user
    end
    def edit
     
    end
    private 
    def new_client_user
      @client_user = ClientUser.new
    end
    def get_client_user
      @client_user = ClientUser.find_by(id: params[:id])
    end
  
    def get_collection
           
      @relation = ClientUser.where("")

      apply_filters

      @client_users = @relation.order(@order_by).page(@current_page).per(@per_page)
    end
    def apply_filters
      @query = params[:q]
      @relation = @relation.search(@query) if @query && !@query.blank?
      @condition=" 1=1 ";
      if params[:country].present?
        @condition += " AND country='#{params[:country]}'" if params.key?(:country)
      end
      if params[:mobile_number].present?
        @condition += " AND mobile_number LIKE '%#{params[:mobile_number]}%'" if params.key?(:mobile_number)
      end
      if params[:name].present?
        @condition += " AND (first_name LIKE '%#{params[:name]}%' OR last_name LIKE '%#{params[:name]}%' OR email LIKE '%#{params[:name]}%' ) " if params.key?(:name)
      end 
      @relation = @relation.advsearch(@condition) if @condition && !@condition.blank?
    end
    def client_user_params
      params.require(:clinet_user).permit(:id, :email, :first_name, :last_name, :mobile_number)
    end
  end
end