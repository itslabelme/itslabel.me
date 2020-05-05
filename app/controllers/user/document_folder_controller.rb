module User
  class DocumentFolderController < User::BaseController

    before_action :authenticate_client_user!
    # before_action :get_document, except: [:new, :create, :index, :select_template]

    def index
    
    end

    def show
    
    end
    def new   
      new_folder  
    end   
   

    def create
      new_folder
      @folder.title=params[:title]
      @folder.user_id=params[:user_id]
      if @folder.valid?
      
        @folder.save
        respond_to do |format|
          format.json { render json: @folder.to_json }
        end
      else
        @folder.errors
      end
    end

   

   
    private

    def new_folder
      @folder = DocumentFolder.new
    end

    def permitted_params
      params.require("folder").permit(
        :title,
        :user_id,
        
      )
    end

  end
end
