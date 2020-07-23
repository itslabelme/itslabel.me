module User
  class DocumentFolderController < User::BaseController

    before_action :authenticate_client_user!
    # before_action :get_document, except: [:new, :create, :index, :select_template]

    def new   
      new_folder  
    end   

    def edit
      existing_folder  
    end

    def create
      new_folder
      @folder.assign_attributes(permitted_params)

      # binding.pry

      if @folder.valid?
        @folder.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "Tests"))
        set_flash_message(I18n.translate("success.created", item: "Tests"), :success)
      else
        @per_page=params[:page]
        message = I18n.t('errors.failed_to_create', item: "AdminUser")
        @folder.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end

    def update
      existing_folder
      @folder.assign_attributes(permitted_params)

      if @folder.valid?
        @folder.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "Tests"))
        set_flash_message(I18n.translate("success.created", item: "Tests"), :success)
      else
        @per_page=params[:page]
        message = I18n.t('errors.failed_to_create', item: "AdminUser")
        @folder.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end

    def destroy
    end

    # Remove document folder
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

      def permitted_params
        params.require("document_folder").permit(
          :title,
          :parent_id
        )
      end

      def new_folder
        @folder = @current_client_user.document_folders.build
        @folders = DocumentFolder.where(user_id: @current_client_user.id)
      end

      def existing_folder
        @folder = @current_client_user.document_folders.find_by_id(params[:id])
        @folders = DocumentFolder.where(user_id: @current_client_user.id)
      end

      # Move the Template Document to Default folder if Template Document exist in the deleted folder
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

      # Move the Table Document to Default folder if Table Document exist in the deleted folder
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
      
      # Create Default folder
      def default_folder
        @current_client_user.default_folder || @current_client_user.create_default_folder
      end
         
  end
end
