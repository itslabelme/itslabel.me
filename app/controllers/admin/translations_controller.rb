module Admin
  class TranslationsController < Admin::BaseController

    before_action :authenticate_admin_user!
    before_action :get_translation, except: [:new, :create, :index]

    def index
      @page_title = "Translations Database"
      @nav = 'admin/translations'

      get_collection
      new_translation

      @en_ar = Translation.where(input_language: "ENGLISH", output_language: "ARABIC").count
      @en_fr = Translation.where(input_language: "ENGLISH", output_language: "FRENCH").count
      @ar_en = Translation.where(input_language: "ARABIC", output_language: "ENGLISH").count
      @ar_fr = Translation.where(input_language: "ARABIC", output_language: "FRENCH").count
      @fr_en = Translation.where(input_language: "FRENCH", output_language: "ENGLISH").count
      @fr_ar = Translation.where(input_language: "FRENCH", output_language: "ARABIC").count

    end

    def show
      @page_title = "Translation"
      @nav = 'admin/translations'
      get_translation
    end

    def new
      @page_title = "Add a Translation"
      @nav = 'admin/translations'
      new_translation
    end

    def edit
      @page_title = "Edit Translation"
      @nav = 'admin/translations'
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

    def apply_filters

      @query = params[:q]
      @order_by = params[:filters].try(:[], :ob)
      # @status = params[:filters].try(:[], :status)

      @relation = @relation.search(@query) if @query && !@query.blank?

      if params[:filters].nil?
        @input_language = "English"
        @output_language = "Arabic"  
      else  
        @input_language = params[:filters].try(:[], :input_language)
        @output_language = params[:filters].try(:[], :output_language)    
      end

      @input_phrase = params[:filters].try(:[], :input_phrase)
      @output_phrase = params[:filters].try(:[], :output_phrase)

      @relation = @relation.search_only_input_phrase(@input_phrase)
      @relation = @relation.search_only_output_phrase(@output_phrase)
      @relation = @relation.search_only_input_language(@input_language)
      @relation = @relation.search_only_output_language(@output_language)

      # @relation = @relation.search_only_status(params[:filters].try(:[], :status))
      @relation = @relation.order_by(params[:filters].try(:[], :ob))
    end

    def get_collection

      # @order_by = "created_at DESC" unless @order_by
      @relation = Translation.where("")

      apply_filters
      
      @translations = @relation.
                        # order(@order_by).
                        page(@current_page).per(@per_page)
    end

    
    def get_sorting

      @order_by = "input_phrase_asc" unless @order_by
      @relation = Translation.where("")

      apply_filters
      
      @translations = @relation.
                        # order(@order_by).
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
         :input_language,
         :output_phrase,
         :output_language,
      )
    end

  end
end
