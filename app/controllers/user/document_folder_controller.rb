module User
  class DocumentFolderController < User::BaseController

    before_action :authenticate_client_user!
    # before_action :get_document, except: [:new, :create, :index, :select_template]

    def new   
      new_folder  
    end   
   
    def create
      new_folder
      
      @folder.title = params[:title]
      
      @parent = DocumentFolder.find_by_id(params[:parent_id])
      @folder.parent = @parent

      if @folder.valid?
        @folder.save
        respond_to do |format|
          format.json { render json: @folder.to_json }
        end
      else
        @folder.errors
      end
    end

    def destroy
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
    end

    private
    
    def change_default_folder_template(id)
      @templates=TemplateDocument.where(folder_id:id,user_id:current_client_user.id).all
      if @templates.present?
        default_folder
        @templates.each do |template|
          #puts template.folder_id
          template.folder_id=@default.id
          template.save
        end
      end 
    end

    def change_default_folder_table(id)
      @tables=TableDocument.where(folder_id:id,user_id:current_client_user.id).all
      if @tables.present?
        default_folder
        @tables.each do |template|
          #puts template.folder_id
          template.folder_id=@default.id
          template.save
        end
      end 
    end
  
    def default_folder
      @current_client_user.default_folder || @current_client_user.create_default_folder
    end
       
    def new_folder
      @folder = @current_client_user.document_folders.build
    end

  end
end
