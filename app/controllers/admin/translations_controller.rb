module Admin
  class TranslationsController < Admin::BaseController

    before_action :authenticate_admin_user!
    before_action :get_translation, except: [:new, :create, :index]

    def index
      @page_title = "Translations Database"

      get_collection
      new_translation
    end

    def show
      @page_title = "Translation"
      get_translation
    end

    def new
      @page_title = "Add a Translation"
      new_translation
    end

    def edit
      @page_title = "Edit Translation"
      get_translation
    end

    def create
      new_translation
      @translation.assign_attributes(permitted_params)
      
      if @translation.valid?
        @translation.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "Translation"))
        set_flash_message(I18n.translate("success.created", item: "Translation"), :success)
      else
        message = I18n.t('errors.failed_to_create', item: "Translation")
        @translation.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end

    def update
      get_translation
      @translation.assign_attributes(permitted_params)
      
      if @translation.valid?
        @translation.save
        set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "Translation"))
        set_flash_message(I18n.translate("success.updated", item: "Translation"), :success)
      else
        message = I18n.t('errors.failed_to_update', item: "Translation")
        @translation.errors.add :base, message
        set_notification(false, I18n.t('status.error'), message)
        set_flash_message('The form has some errors. Please correct them and submit again', :error)
      end
    end

    def destroy
      get_translation

      if @translation
        if @translation.can_be_deleted?
          @translation.destroy
          
          set_notification(false, I18n.t('status.success', item: "Translation"), I18n.t('success.deleted', item: "Translation"))
          set_flash_message(I18n.t('success.deleted', item: "Translation"), :success, false)
          @destroyed = true
        else
          message = I18n.t('errors.cannot_be_deleted', item: "Translation", reason: @translation.errors.full_messages.join("<br>"))
          set_flash_message(message, :failure)
          set_notification(false, I18n.t('status.error'), message)
          @destroyed = false
        end
      end
    end

    private

    def get_collection
      @order_by = "created_at DESC" unless @order_by
      @translations = Translation.
                        order(@order_by).
                        page(@current_page).per(@per_page)
    end

    def get_translation
      @translation = Translation.find_by_id(params[:id])
    end

    def new_translation
      @translation = Translation.new
    end

    def permitted_params
      params.require("translation").permit(
         :input_phrase,
         :input_description,
         :input_language,
         :output_phrase,
         :output_description,
         :output_language,
      )
    end

  end
end