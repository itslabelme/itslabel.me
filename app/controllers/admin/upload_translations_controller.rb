module Admin
  class UploadTranslationsController < Admin::BaseController

    require 'csv'

    def index
      @page_title = "Upload Translation Data"
      @nav = 'admin/translations'
      @errors = {}
      @summary = {}
    end

    def create
      csv_file = params[:file]
      error = nil

      @csv_contents = nil
      
      if csv_file
        begin
          @csv_contents = CSV.read(csv_file.path)
         rescue
          error = "Unable to read the contents of the uploaded file, Please upload valid file"
        end
      else 
        error = "CSV file not uploaded"
      end

      if is_csv_in_right_format? == false
        error = "The format of the CSV is not correct. Please download the template, fill in the data and upload again."
      elsif is_csv_empty?
        error = "CSV is blank - no contents found"
      end

      if error.blank?
        save_csv_file
        save_upload_history
        
        ParseUploadedDatabaseJob.perform_later(
          @upload_history.file_path,
          current_admin_user,
          @upload_history.id
        )

        # Translation.import_data_from_csv(
        #   @upload_history.file_path,
        #   current_admin_user,
        #   @upload_history.id
        # )
      
        set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "Translation"))
        set_flash_message(I18n.translate("success.created", item: "Translation"), :success)
      else
        set_notification(false, I18n.t('status.error'), error)
        set_flash_message(error, :error)
      end
    end

    private

    def is_csv_in_right_format?
      return false if @csv_contents.blank?
      return false unless @csv_contents.is_a?(Array)
      return false unless @csv_contents.try(:first).is_a?(Array)
      
      # FIXME - this needs to be fixed properly
      return false unless @csv_contents[0][0].upcase.include?("CATEGORY")
      return false unless @csv_contents[0][1].upcase.include?("ENGLISH")
      return false unless @csv_contents[0][2].upcase.include?("ARABIC")
      return false unless @csv_contents[0][3].upcase.include?("FRENCH")
      return false unless @csv_contents[0][4].upcase.include?("SPANISH")
      return true
    end

    def is_csv_empty?
      return true if @csv_contents[1].blank?
      return true unless @csv_contents[1].is_a?(Array)
      return false
    end

    def save_csv_file
      @csv_path = "#{Rails.root}/public/imported_files/UPLOAD_DATA_#{DateTime.now.strftime '%d.%m.%Y:%H.%M.%S'}.csv"
      CSV.open(@csv_path, "wb") do |csv|  
        @csv_contents.each do |csv_content|
         csv << [csv_content[0],csv_content[1],csv_content[2],csv_content[3]]
        end
      end 
    end

    def save_upload_history
      @upload_history = UploadsHistory.new(admin_user:current_admin_user.first_name, file_path: @csv_path)
      @upload_history.save
    end
    
    
  end
end
