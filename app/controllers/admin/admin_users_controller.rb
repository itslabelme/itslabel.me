module Admin
  class AdminUsersController < Admin::BaseController
    before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_admin_user!
     respond_to :html, :json
    def index

      @page_title = "Admin Users | Admin"
      @per_page=params[:page]
      if (params.has_key? (:q))
         key = "%#{params[:q]}%"
         @admin_users = AdminUser.where('first_name LIKE :search OR last_name LIKE :search OR email LIKE :search', search: key).page(@per_page).per(@current_page)
      else
       @admin_users = AdminUser.page(@per_page).per(@current_page)
      end
        @admin_user = AdminUser.new   
    end
    
    def new   
      @user = AdminUser.new   
    end   
   
    # POST method for processing form data   
    def create   
      @user = AdminUser.new(admin_user_params)  
      
      
      respond_to do |format|

          if @user.save
            format.html { redirect_to '/admin/admin_users/', notice: 'User was successfully created.' }
            format.js
            format.json { render json: @user, status: :created, location: @user }
          else
             @per_page=params[:page]
             @admin_users = AdminUser.all
             @admin_user = AdminUser.new   
             format.html { render :index }
             format.js {render :index}
          end
      end 
  end  
     
    
    def edit
      @page_title = "Admin Users | Admin"
      
    end
    # PATCH/PUT /admin_user/1
    def update
      @user = AdminUser.find(params[:id])   
      if @user.update_attributes(admin_user_params)   
        flash[:notice] = 'User updated!'   
        redirect_to '/admin/admin_users/'  
      else   
        flash[:error] = 'Failed to edit user!'   
        render :edit   
      end  
    end
    
    def set_admin_user
      @admin_user = AdminUser.find(params[:id])
    end
    
    def admin_user_params
      params.require(:admin_user).permit(:id, :first_name, :last_name,:password, :email, :organisation,:phone)
    end
    # DELETE method for deleting a user from database based on id   
    def destroy   
      @user = AdminUser.find(params[:id]) 
      if @user.delete   
        flash[:notice] = 'User deleted!'   
        redirect_to '/admin/admin_users/'  
      else   
        flash[:error] = 'Failed to delete this user'   
        render :destroy   
      end   
    end  
    
  end
end
