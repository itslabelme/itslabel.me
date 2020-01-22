module Admin
  class TemplatesController < Admin::BaseController

    before_action :authenticate_admin_user!
    before_action :get_template, except: [:new, :create, :index]

    def index
      @page_title = "Templates Database"
      @nav = 'admin/templates'

      get_collection
      new_template
    end

    def show
      @page_title = "Template"
      @nav = 'admin/templates'
      get_template
    end

    def new
      @page_title = "Add a Template"
      @nav = 'admin/templates'
      new_template
    end

    def edit
      @page_title = "Edit Template"
      @nav = 'admin/templates'
      get_template
    end

    def create
      new_template
      @template.assign_attributes(permitted_params)
      
      if @template.valid?
        @template.admin_user = @current_user
        @template.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "Template"))
        set_flash_message(I18n.translate("success.created", item: "Template"), :success)
      else
        message = I18n.t('errors.failed_to_create', item: "Template")
        @template.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end

    def update
      get_template
      @template.assign_attributes(permitted_params)
      
      if @template.valid?
        @template.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "Template"))
        set_flash_message(I18n.translate("success.updated", item: "Template"), :success)
      else
        message = I18n.t('errors.failed_to_update', item: "Template")
        @template.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end

    def destroy
      get_template

      if @template
        if @template.can_be_deleted?
          @template.destroy
          
          set_notification(false, I18n.t('status.success', item: "Template"), I18n.t('success.deleted', item: "Template"))
          set_flash_message(I18n.t('success.deleted', item: "Template"), :success, false)
          @destroyed = true
        else
          message = I18n.t('errors.cannot_be_deleted', item: "Template", reason: @template.errors.full_messages.join("<br>"))
          set_flash_message(message, :failure)
          set_notification(false, I18n.t('status.error'), message)
          @destroyed = false
        end
      end
    end

    private

    def get_collection
      @order_by = "created_at DESC" unless @order_by
      @templates = Template.
                        order(@order_by).
                        page(@current_page).per(@per_page)
    end

    def get_template
      @template = Template.find_by_id(params[:id])
    end

    def new_template
      @template = Template.new
    end

    def permitted_params
      params.require("templates").permit(
       :name,
       :description,
       :style,
       :ltr_html_source,
       :rtl_html_source
      )
    end

  end
end
