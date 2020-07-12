module Admin
  class LabelTemplatesController < Admin::BaseController

    before_action :authenticate_admin_user!
    before_action :get_label_template, except: [:new, :create, :index,:show]

    def index
      @page_title = "Label Templates Database"
      @nav = 'admin/label_templates'

      get_collection
      new_label_template
    end

    def show
      @page_title = "Label Template"
      @nav = 'admin/label_templates'
      get_label_template
    end

    def new
      @page_title = "Add a Label Template"
      @nav = 'admin/label_templates'
      new_label_template
    end

    def edit
      @page_title = "Edit Label Template"
      @nav = 'admin/label_templates'
      get_label_template
    end

    def create
      new_label_template
      @label_template.assign_attributes(permitted_params)
      @label_template.admin_user = @current_admin_user

      @label_template.latest = false
      @label_template.latest = true if permitted_params[:latest] == "on"

      if @label_template.valid?
       
        @label_template.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "Label Template"))
        set_flash_message(I18n.translate("success.created", item: "Label Template"), :success)
      else
        message = I18n.t('errors.failed_to_create', item: "Label Template")
        @label_template.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end

    def update
      get_label_template
      @label_template.assign_attributes(permitted_params)
      
      @label_template.latest = false
      @label_template.latest = true if permitted_params[:latest] == "on"

      if @label_template.valid?
        @label_template.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "Label Template"))
        set_flash_message(I18n.translate("success.updated", item: "Label Template"), :success)
      else
        message = I18n.t('errors.failed_to_update', item: "Label Template")
        @label_template.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end

    def destroy
      get_label_template

      if @label_template
        if @label_template.can_be_deleted?
          @label_template.destroy
          
          set_notification(false, I18n.t('status.success', item: "Label Template"), I18n.t('success.deleted', item: "Label Template"))
          set_flash_message(I18n.t('success.deleted', item: "Label Template"), :success, false)
          @destroyed = true
        else
          message = I18n.t('errors.cannot_be_deleted', item: "Label Template", reason: @label_template.errors.full_messages.join("<br>"))
          set_flash_message(message, :failure)
          set_notification(false, I18n.t('status.error'), message)
          @destroyed = false
        end
      end
    end

    private

    def get_collection
      @order_by = "created_at DESC" unless @order_by
      @label_templates = LabelTemplate.
                        order(@order_by).
                        page(@current_page).per(@per_page)
    end

    def get_label_template
      @label_template = LabelTemplate.find_by_id(params[:id])
    end

    def new_label_template
      @label_template = LabelTemplate.new
    end

    def permitted_params
      params.require(:label_template).permit(
       :name,
       :description,
       :style,
       :ltr_html_source,
       :rtl_html_source,
       :picture,
       :latest,
       :status,
       :admin_user)
    end

  end
end
