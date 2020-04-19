module User
 class ExportFreetranslationsController < User::BaseController
  
    before_action :authenticate_client_user!
    
    def export_pdf
     
     respond_to do |format|
      format.html
      format.pdf do
        render :pdf => 'file_name',
        :template => 'user/export_freetranslations/export_pdf.pdf.erb',
        :layout => 'pdf.html.erb',
        :show_as_html => params[:debug].present?
      end
    end
    end
  
    def get_post_data
     @output=params[:translation_outputs]
      respond_to do |format|
    format.html { redirect_to(user_export_pdf_url) }
    format.json   { render :output => params[:translation_outputs] }
  end 
     #redirect_to user_export_pdf_url(@output, format: 'pdf') && return
    end

 end

end
