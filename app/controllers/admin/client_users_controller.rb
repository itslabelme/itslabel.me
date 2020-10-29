module Admin
  class ClientUsersController < Admin::BaseController

    before_action :authenticate_admin_user!
    before_action :get_client_user, except:[:index]

    def index
      @page_title = "Registrations"
      @nav = "admin/registrations"
    
      get_collection 
      new_client_user
    end

    def forgot_password
      get_client_email
      if @email.exist?
        puts "already exist"
      else
        puts "doesn't exist"
      end      
    end

    def show
      get_client_user
    end

    private 

    def new_client_user
      @client_user = ClientUser.new
    end

    def get_client_user
      @client_user = ClientUser.find_by(id: params[:id])
    end

    def get_client_email
      params_email = params.require(:client_user).permit(:email)
      @email = params_email[:email]
    end
  
    def get_collection
      @relation = ClientUser.where("")

      apply_filters

      @client_users = @relation.order(@order_by).page(@current_page).per(@per_page)
    end

    def apply_filters
      @query = params[:q]
      @relation = @relation.search(@query) if @query && !@query.blank?
      @relation = @relation.filter_by_country(params[:filters].try(:[], :country))
      @relation = @relation.search_only_mobile_number(params[:filters].try(:[], :mobile_number))
    end

    def client_user_params
      params.require(:client_user).permit(:id, :email, :first_name, :last_name, :mobile_number)
    end

  end
end