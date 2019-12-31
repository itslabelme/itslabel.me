module Admin
  class TranslationsController < Admin::BaseController

    before_action :authenticate_admin_user!

    # include ControllerConfigurations::SelfService::LeaveRequestsCc
    # include TableSettings::SelfService::LeaveRequestsTs
  
    def index
      @page_title = "Translations List | Admin"
      @translations = Translation.all
      @translation = Translation.new
    end

    def show
      @page_title = "Translation | Admin"
    end

    def new
      @page_title = "Create Translation | Admin"
      @translation = Translation.new
    end

    def edit
      @page_title = "Edit Translation | Admin"
      render "index"
    end

    def create
      @translation = Translation.new
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
    end

    def destroy
    end

    private

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
