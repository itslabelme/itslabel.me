module Admin
  class TranslationsController < Admin::BaseController

    before_action :authenticate_admin_user!

    include Manava::ControllerConfigurations::SelfService::LeaveRequestsCc
    include Manava::TableSettings::SelfService::LeaveRequestsTs
  
    def index
      @page_title = "Translations List | Admin"
    end

    def show
      @page_title = "Translation | Admin"
    end

    def new
      @page_title = "Create Translation | Admin"
    end

    def edit
      @page_title = "Edit Translation | Admin"
    end

    def create
    end

    def update
    end

    def destroy
    end


  end
end
