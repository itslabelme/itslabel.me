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
       render json: { error: @folder.errors.to_json }
      end
    end

     def destroy
 
    end
   def update
      get_folder
     # raise params.inspect
      @folder.title= params[:title]
      @folder.user_id= params[:user_id]
      if @folder.valid?
         @folder.save
         respond_to do |format|
          format.json { render json: @folder.to_json }
        end
      else
        
           render json: { error: @folder.errors.to_json }
         
      end
   end
     
    def update_document
      @folder_id= params[:folder_id]
      @folder=DocumentFolder.find(@folder_id)
          
          if @folder
          change_default_folder_template(@folder.id)
          change_default_folder_table(@folder.id)
          @folder.destroy
          @destroyed = true
    
      end
        #raise @templates.inspect
      
    end
    private
    
     def change_default_folder_template(id)
        @templates=TemplateDocument.where(folder_id:id,user_id:current_client_user.id).all
        if @templates.present?
          get_default_folder
          @templates.each do |template|
            
            template.folder_id=@default.id
            template.save
          end
        end 
     end
     def change_default_folder_table(id)
        @tables=TableDocument.where(folder_id:id,user_id:current_client_user.id).all
        if @tables.present?
          get_default_folder
          @tables.each do |template|
          
            template.folder_id=@default.id
            template.save
          end
        end 
     end
     def get_default_folder
       @default=DocumentFolder.where(user_id:current_client_user.id,title:'Default').first
     end
     def get_folder
       @folder=DocumentFolder.find(params[:id])
     end
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
